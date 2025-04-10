import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/login_controller.dart';

class LoginCard extends StatefulWidget {
  const LoginCard({super.key});

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  Widget buildLoginButton(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (ctr) => ElevatedButton(
        onPressed: ctr.onTapLogin,
        child: Center(
          child: ctr.isLogin
              ? const CupertinoActivityIndicator(radius: 6)
              : const Text("登录"),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final LoginController ctr = Get.find<LoginController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: ctr.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: ctr.userIdCtr,
              decoration: const InputDecoration(labelText: "请输入账号"),
              validator: (string) {
                if (string == null || string.trim().isEmpty) {
                  return "请输入账号";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: ctr.passwordCtr,
              decoration: const InputDecoration(labelText: "请输入密码"),
              validator: (string) {
                if (string == null || string.trim().isEmpty) {
                  return "请输入密码";
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            buildLoginButton(context),
          ],
        ),
      ),
    );
  }
}
