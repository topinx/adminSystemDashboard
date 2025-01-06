import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/pages.dart';
import 'package:top_back/bean/bean_register.dart';
import 'package:top_back/contants/app_storage.dart';
import 'package:top_back/contants/http_constants.dart';
import 'package:top_back/network/request_mixin.dart';

class LoginController extends GetxController with RequestMixin {
  bool isLogin = false, isRegister = false;

  final GlobalKey<FormState>? formKey = GlobalKey<FormState>();

  TextEditingController userIdCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();

  @override
  void onClose() {
    super.onClose();
    userIdCtr.dispose();
    passwordCtr.dispose();
  }

  Future<void> onTapLogin() async {
    if (formKey?.currentState!.validate() == false) {
      return;
    }

    isLogin = true;
    update();
    String password = encryptPassword(passwordCtr.text);
    await post(HttpConstants.login,
        param: {"userId": userIdCtr.text, "password": password},
        success: onLoginSuccess);
    isLogin = false;
    update();
  }

  Future<void> onTapRegister() async {
    isRegister = true;
    update();
    await post(HttpConstants.register, param: {}, success: onRegisterSuccess);
    isRegister = false;
    update();
  }

  void onLoginSuccess(data) {
    AppStorage().saveUserFromHttp(data);
    Get.offAllNamed(Routes.home);
  }

  void onRegisterSuccess(data) {
    BeanRegister bean = BeanRegister.fromJson(data);
    userIdCtr.text = "${bean.userId}";
    passwordCtr.text = "${bean.userId}@123456";
  }
}
