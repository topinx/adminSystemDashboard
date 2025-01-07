import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/view_container.dart';

import 'controller/account_manage_controller.dart';
import 'widget/account_create_birth.dart';
import 'widget/account_create_gender.dart';
import 'widget/account_create_image.dart';
import 'widget/account_create_input.dart';
import 'widget/account_create_phone.dart';

class AccountManageView extends StatefulWidget {
  const AccountManageView({super.key});

  @override
  State<AccountManageView> createState() => _AccountManageViewState();
}

class _AccountManageViewState extends State<AccountManageView> {
  final AccountManageController ctr = Get.find<AccountManageController>();

  Widget buildCreateButton() {
    return GetBuilder<AccountManageController>(builder: (ctr) {
      return OutlinedButton(
        style: OutlinedButton.styleFrom(fixedSize: const Size.fromWidth(100)),
        onPressed: ctr.onTapConfirm,
        child: ctr.isLoading
            ? const CupertinoActivityIndicator(radius: 6)
            : const Text("确定"),
      );
    });
  }

  Widget buildViewContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("基本信息",
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
        const SizedBox(height: 20),
        const AccountCreateAvatar("用户头像"),
        const SizedBox(height: 20),
        AccountCreateInput(
          "用户昵称",
          need: true,
          validator: ctr.validatorNick,
          input: ctr.inputNick,
        ),
        const SizedBox(height: 20),
        const AccountCreateGender(),
        const SizedBox(height: 20),
        const AccountCreateBirth(),
        const SizedBox(height: 20),
        const AccountCreatePhone(),
        const SizedBox(height: 20),
        AccountCreateInput("邮箱", input: ctr.inputEmail),
        const SizedBox(height: 20),
        AccountCreateInput(
          "密码",
          need: true,
          validator: ctr.validatorPassword,
          input: ctr.inputPassword,
          formatter: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z]')),
            LengthLimitingTextInputFormatter(16),
          ],
        ),
        const SizedBox(height: 20),
        AccountCreateInput("用户简介", maxWidth: 330, input: ctr.inputBrief),
        const SizedBox(height: 20),
        const AccountCreateCover("背景图"),
        const SizedBox(height: 40),
        Center(child: buildCreateButton())
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewContainer(
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Form(key: ctr.formKey, child: buildViewContent()),
      ),
    );
  }
}
