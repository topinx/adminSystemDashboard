import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:top_back/bean/bean_account.dart';
import 'package:top_back/constants/http_constants.dart';
import 'package:top_back/network/dio_request.dart';
import 'package:top_back/pages/page_account/provider/account_provider.dart';
import 'package:top_back/pages/widget/common_button.dart';
import 'package:top_back/pages/widget/page_card.dart';
import 'package:top_back/pages/widget/table/async_table.dart';
import 'package:top_back/router/router.dart';
import 'package:top_back/toast/toast.dart';

import 'widget/user_filter_drop.dart';
import 'widget/user_filter_input.dart';

class AccountManager extends ConsumerStatefulWidget {
  const AccountManager({super.key});

  @override
  ConsumerState createState() => _AccountManagerState();
}

class _AccountManagerState extends ConsumerState<AccountManager> {
  final TextEditingController inputN = TextEditingController();
  final TextEditingController inputP = TextEditingController();
  final TextEditingController inputE = TextEditingController();

  final stateList1 = ["全部", "正常使用", "已停用"];
  final stateList2 = ["全部", "普通用户", "认证博主", "认证商户"];

  final columns = ["账号名称", "手机号", "邮箱", "认证状态", "状态", "操作"];

  AsyncTableController<BeanAccount> controller =
      AsyncTableController<BeanAccount>();

  @override
  void initState() {
    super.initState();
    controller.initialize(columns: columns, future: requestBeanList);

    onTapSearch();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    inputN.dispose();
    inputP.dispose();
    inputE.dispose();
  }

  void onTapSearch({int? page = 1}) async {
    int dataLen = await requestBeanCount();
    controller.updateDataLen(dataLen);
    controller.fetchData(page: page);
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

  void onDropChanged(String? string) {
    if (controller.selection.isEmpty) return Toast.showToast("请先选择账号");

    if (string == "批量启用") {
      requestModify(1);
    } else if (string == "批量停用") {
      requestModify(0);
    }
  }

  void onTapUser(BeanAccount account) {
    context.push(RouterPath.account_info(account.userId));
  }

  ({String key, List<Widget> widgetList}) buildTabRowList(BeanAccount bean) {
    String status1 = ["", "普通用户", "认证博主", "认证商户"][bean.authenticationStatus];
    String status2 = ["已停用", "正常使用"][bean.status];

    List<Widget> beanList = [
      AsyncText(bean.nickname),
      AsyncText(bean.phone),
      AsyncText(bean.email),
      AsyncText(status1),
      AsyncText(status2),
      TxtButton("查看详情", onTap: () => onTapUser(bean))
    ];

    return (key: "${bean.userId}", widgetList: beanList);
  }

  Future<List<BeanAccount>> requestBeanList(int page, int limit) async {
    final param = ref.read(accountSearchParam);

    final query = {
      "pageNo": page,
      "limit": limit,
      "nickname": param.nick,
      "phone": param.phone,
      "email": param.email,
      "status": param.state_a_param,
      "authenticationStatus": param.state_v_param,
    };

    final response =
        await DioRequest().request(HttpConstant.accountList, query: query);

    final tempList = response["list"] ?? [];
    List<BeanAccount> beanList = List<BeanAccount>.from(
      tempList.map((x) => BeanAccount.fromJson(x)),
    );
    return beanList;
  }

  Future<int> requestBeanCount() async {
    final param = ref.read(accountSearchParam);

    final query = {
      "nickname": param.nick,
      "phone": param.phone,
      "email": param.email,
      "status": param.state_a_param,
      "authenticationStatus": param.state_v_param,
    };

    return await DioRequest().request(HttpConstant.accountCnt, query: query);
  }

  Future<void> requestModify(int status) async {
    Toast.showLoading();

    var response = await DioRequest().request(
      HttpConstant.modifyStatus,
      method: DioMethod.POST,
      data: {
        "userIdList": controller.selection.map((x) => x.userId).toList(),
        "status": status
      },
    );
    Toast.dismissLoading();

    if (response is bool && !response) return;
    Toast.showToast("修改成功", true);

    onTapSearch(page: null);
  }

  @override
  Widget build(BuildContext context) {
    var paramProvider = ref.watch(accountSearchParam);
    var count = ref.watch(accountCnt2);

    return PageCard(
      view: Column(children: [
        Row(children: [
          Expanded(flex: 2, child: UserFilterInput(inputN, "用户昵称")),
          const Spacer(),
          Expanded(flex: 2, child: UserFilterInput(inputN, "用户手机")),
          const Spacer(),
          Expanded(flex: 2, child: UserFilterInput(inputN, "用户邮箱")),
          const Spacer(),
        ]),
        const SizedBox(height: 20),
        Row(children: [
          Expanded(
            flex: 2,
            child: UserFilterDrop("账号状态", stateList1[paramProvider.state_a],
                (_, __) async => stateList1,
                onChanged: onStateAChanged),
          ),
          const Spacer(),
          Expanded(
            flex: 2,
            child: UserFilterDrop("认证状态", stateList2[paramProvider.state_v],
                (_, __) async => stateList2,
                onChanged: onStateVChanged),
          ),
          const Spacer(),
          Expanded(
              flex: 2,
              child: Text("共${count.value ?? 0}个用户", textAlign: TextAlign.end)),
          const Spacer(),
        ]),
        const SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          BorderButton("查询", onTap: onTapSearch),
          const SizedBox(width: 20),
          BorderButton("重置", onTap: onTapReset),
          const SizedBox(width: 20),
          DropButton(
            "批量处理",
            (_, __) async => ["批量启用", "批量停用"],
            onChanged: onDropChanged,
          ),
        ]),
        const SizedBox(height: 20),
        Expanded(
          child: AsyncTable(ctr: controller, builder: buildTabRowList),
        ),
      ]),
    );
  }
}
