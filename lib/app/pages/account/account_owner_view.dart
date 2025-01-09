import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/dropdown_btn.dart';
import 'package:top_back/app/widgets/page_indicator.dart';
import 'package:top_back/app/widgets/view_container.dart';

import 'controller/account_owner_controller.dart';
import 'widget/account_input_field.dart';
import 'widget/account_status_field.dart';
import 'widget/account_owner_table.dart';

class AccountOwnerView extends StatefulWidget {
  const AccountOwnerView({super.key});

  @override
  State<AccountOwnerView> createState() => _AccountOwnerViewState();
}

class _AccountOwnerViewState extends State<AccountOwnerView> {
  final AccountOwnerController ctr = Get.find<AccountOwnerController>();

  Widget buildInputContent() {
    return Row(children: [
      AccountInputField("用户昵称", ctr.inputName),
      AccountInputField("手机号", ctr.inputPhone),
      AccountInputField("邮箱", ctr.inputEmail)
    ]);
  }

  Widget buildFilterContent() {
    return Row(children: [
      GetBuilder<AccountOwnerController>(
          id: "check-status",
          builder: (ctr) => AccountStatusField(
                ctr.statusAccount,
                "账号状态",
                const ["全部", "正常使用", "已停用"],
                onChanged: ctr.onStatusAChanged,
              )),
      GetBuilder<AccountOwnerController>(
          id: "check-status",
          builder: (ctr) => AccountStatusField(
                ctr.statusVerify,
                "认证状态",
                const ["全部", "普通用户", "认证博主", "认证商户"],
                onChanged: ctr.onStatusVChanged,
              )),
      GetBuilder<AccountOwnerController>(
        id: "user-count",
        builder: (ctr) => StatusText("共${ctr.accountCnt}个用户"),
      ),
    ]);
  }

  Widget buildButtonContent() {
    ButtonStyle style =
        OutlinedButton.styleFrom(fixedSize: const Size.fromWidth(100));

    TextStyle textStyle = const TextStyle(fontSize: 14, color: Colors.black);

    Widget content = Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      OutlinedButton(
          style: style, onPressed: ctr.onTapSearch, child: const Text("查询")),
      const SizedBox(width: 30),
      OutlinedButton(
          style: style, onPressed: ctr.onTapReset, child: const Text("重置")),
      const SizedBox(width: 30),
      OutlinedButton(
          style: style, onPressed: ctr.onTapCreate, child: const Text("创建账号")),
      const SizedBox(width: 30),
      DropdownBtn(
          hint: "批量处理",
          width: 100,
          height: 36,
          onChanged: ctr.onMultiOperate,
          selectedItemBuilder: (_) => [
                Center(child: Text("批量处理", style: textStyle)),
                Center(child: Text("批量处理", style: textStyle)),
              ],
          menuList: const ["批量启用", "批量停用"]),
    ]);

    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        reverse: true,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        child: content,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewContainer(
      child: Column(children: [
        buildInputContent(),
        const SizedBox(height: 20),
        buildFilterContent(),
        const SizedBox(height: 20),
        buildButtonContent(),
        const SizedBox(height: 20),
        const Expanded(child: AccountOwnerTable()),
        GetBuilder<AccountOwnerController>(
            id: "check-page",
            builder: (ctr) {
              return PageIndicator(
                itemCount: ctr.checkCnt,
                onTapPage: ctr.onTapPage,
                curPage: ctr.pageNum,
                onSizeChang: ctr.onPageSizeChanged,
              );
            }),
      ]),
    );
  }
}
