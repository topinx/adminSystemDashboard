import 'package:top_back/bean/bean_account.dart';
import 'package:top_back/pages/page_account/provider/account_provider.dart';
import 'package:top_back/pages/widget/common.dart';
import 'package:top_back/pages/widget/common_button.dart';
import 'package:top_back/pages/widget/input_drop.dart';
import 'package:top_back/pages/widget/input_filed.dart';
import 'package:top_back/pages/widget/table_record.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountOwner extends ConsumerStatefulWidget {
  const AccountOwner({super.key});

  @override
  ConsumerState createState() => _AccountOwnerState();
}

class _AccountOwnerState extends ConsumerState<AccountOwner> {
  final TextEditingController inputN = TextEditingController();
  final TextEditingController inputP = TextEditingController();
  final TextEditingController inputE = TextEditingController();

  final stateList1 = ["全部", "正常使用", "已停用"];
  final stateList2 = ["全部", "普通用户", "认证博主", "认证商户"];

  final tabTitles = [
    TabColumn("账号名称"),
    TabColumn("手机号"),
    TabColumn("邮箱"),
    TabColumn("认证状态"),
    TabColumn("状态"),
    TabColumn("操作")
  ];

  @override
  void dispose() {
    super.dispose();
    inputN.dispose();
    inputP.dispose();
    inputE.dispose();
  }

  void onTapSearch() {
    ref.read(accountProvider.notifier).refresh();
  }

  void onTapReset() {
    inputN.text = "";
    inputP.text = "";
    inputE.text = "";

    ref.read(accountSearchParam.notifier).defParam();
  }

  void onStateAChanged(String? string) {
    if (string == null) return;
    int index = stateList1.indexOf(string);
    if (index == -1) return;
    ref.read(accountSearchParam).state_a = index;
  }

  void onStateVChanged(String? string) {
    if (string == null) return;
    int index = stateList2.indexOf(string);
    if (index == -1) return;
    ref.read(accountSearchParam).state_v = index;
  }

  Widget buildTabRowList(int column, BeanAccount bean) {
    String status1 = ["", "普通用户", "认证博主", "认证商户"][bean.authenticationStatus];
    String status2 = ["已停用", "正常使用"][bean.status];

    return [
      TabText(bean.nickname),
      TabText(bean.phone),
      TabText(bean.email),
      TabText(status1),
      TabText(status2),
      TxtButton("查看详情")
    ][column];
  }

  @override
  Widget build(BuildContext context) {
    var paramProvider = ref.watch(accountSearchParam);

    var countProvider = ref.watch(accountCntProvider);
    var account = ref.watch(accountProvider);

    return Column(children: [
      Row(children: [
        Expanded(flex: 2, child: InputFiled(inputN, "用户昵称")),
        const Spacer(),
        Expanded(flex: 2, child: InputFiled(inputN, "用户手机")),
        const Spacer(),
        Expanded(flex: 2, child: InputFiled(inputN, "用户邮箱")),
        const Spacer(),
      ]),
      const SizedBox(height: 20),
      Row(children: [
        Expanded(
          flex: 2,
          child: InputDrop("账号状态", stateList1[paramProvider.state_a],
              (_, __) async => stateList1,
              onChanged: onStateAChanged),
        ),
        const Spacer(),
        Expanded(
          flex: 2,
          child: InputDrop("认证状态", stateList2[paramProvider.state_v],
              (_, __) async => stateList2,
              onChanged: onStateVChanged),
        ),
        const Spacer(),
        Expanded(
            flex: 2,
            child: Text("共${countProvider.value ?? 0}个用户",
                textAlign: TextAlign.end)),
        const Spacer(),
      ]),
      const SizedBox(height: 20),
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        BorderButton("查询", onTap: onTapSearch),
        const SizedBox(width: 20),
        BorderButton("重置", onTap: onTapReset),
        const SizedBox(width: 20),
        BorderButton("创建账号"),
        const SizedBox(width: 20),
        DropButton("批量处理", (_, __) async => ["批量启用", "批量停用"]),
      ]),
      const SizedBox(height: 20),
      Expanded(
        child: account.when(
          data: (response) => TableRecord(
            tabTitles: tabTitles,
            dataLen: response.count,
            builder: (column, row) =>
                buildTabRowList(column, response.beanList[row]),
          ),
          loading: () => const CommonLoading(),
          error: (error, _) => CommonError(error),
        ),
      ),
    ]);
  }
}
