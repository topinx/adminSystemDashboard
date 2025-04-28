import 'package:flutter/material.dart';

class AccountManager extends StatefulWidget {
  const AccountManager({super.key});

  @override
  State<AccountManager> createState() => _AccountManagerState();
}

class _AccountManagerState extends State<AccountManager> {
  final columns = ["账号名称", "手机号", "邮箱", "认证状态", "状态", "操作"];

  @override
  Widget build(BuildContext context) {
    return Column(children: []);
  }
}
