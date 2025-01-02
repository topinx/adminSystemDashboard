import 'package:flutter/material.dart';

class LoginCard extends StatefulWidget {
  const LoginCard({super.key});

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  Widget buildLoginButton(BuildContext context) {
    Widget button = ElevatedButton(
      onPressed: () {},
      child: const Text("登录"),
    );

    return SizedBox(width: double.infinity, child: button);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: "请输入账号"),
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(labelText: "请输入密码"),
          ),
          const SizedBox(height: 30),
          buildLoginButton(context),
        ],
      ),
    );
  }
}
