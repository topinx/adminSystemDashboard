import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/dropdown_btn.dart';
import 'package:top_back/app/widgets/page_indicator.dart';

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
      AccountStatusField(
        "账号状态",
        const ["全部", "正常使用", "已停用"],
        onChanged: ctr.onStatusAChanged,
      ),
      AccountStatusField(
        "认证状态",
        const ["全部", "普通用户", "认证博主", "认证商户"],
        onChanged: ctr.onStatusVChanged,
      ),
      GetBuilder<AccountOwnerController>(
        id: "user-count",
        builder: (ctr) => StatusText("共${ctr.accountCnt}用户"),
      ),
    ]);
  }

  Widget buildButtonContent() {
    ButtonStyle style =
        OutlinedButton.styleFrom(fixedSize: const Size.fromWidth(100));

    TextStyle textStyle = const TextStyle(fontSize: 14);

    return LayoutBuilder(builder: (_, constraints) {
      Widget content = SizedBox(
        width: constraints.maxWidth < 640 ? 640 : constraints.maxWidth,
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          OutlinedButton(
              style: style,
              onPressed: ctr.onTapSearch,
              child: const Text("查询")),
          const SizedBox(width: 30),
          OutlinedButton(
              style: style, onPressed: ctr.onTapReset, child: const Text("重置")),
          const SizedBox(width: 30),
          OutlinedButton(
              style: style,
              onPressed: ctr.onTapCreate,
              child: const Text("创建账号")),
          const SizedBox(width: 30),
          DropdownBtn(
              hint: Center(child: Text("批量处理", style: textStyle)),
              width: 100,
              height: 36,
              selectedItemBuilder: (_) => [
                    Center(child: Text("批量启用", style: textStyle)),
                    Center(child: Text("批量停用", style: textStyle)),
                  ],
              menuList: const ["批量启用", "批量停用"]),
        ]),
      );

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        child: content,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(children: [
        buildInputContent(),
        const SizedBox(height: 20),
        buildFilterContent(),
        const SizedBox(height: 20),
        buildButtonContent(),
        const SizedBox(height: 20),
        const Expanded(child: AccountOwnerTable()),
        const PageIndicator(itemCount: 400),
      ]),
    );
  }
}
