import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountOwnerController extends GetxController {
  TextEditingController inputName = TextEditingController();
  TextEditingController inputPhone = TextEditingController();
  TextEditingController inputEmail = TextEditingController();

  /// 账号状态 0 全部 1 正常使用 2 已停用
  int statusAccount = 0;

  /// 认证状态 0 全部 1 普通用户 2 认证博主 3 认证商户
  int statusVerify = 0;

  /// 用户数量
  int accountCnt = 0;

  @override
  void onClose() {
    super.onClose();
    inputName.dispose();
    inputPhone.dispose();
    inputEmail.dispose();
  }

  void onTapSearch() {}

  void onTapReset() {}

  void onTapCreate() {}

  void onStatusAChanged(int status) {}

  void onStatusVChanged(int status) {}
}
