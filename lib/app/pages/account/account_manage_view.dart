import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/account_manage_controller.dart';

class AccountManageView extends StatefulWidget {
  const AccountManageView({super.key});

  @override
  State<AccountManageView> createState() => _AccountManageViewState();
}

class _AccountManageViewState extends State<AccountManageView> {
  final AccountManageController ctr = Get.find<AccountManageController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
