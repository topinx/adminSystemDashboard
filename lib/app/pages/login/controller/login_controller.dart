import 'package:encrypt/encrypt.dart';
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

  final String _publicPem = '''
-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC90FUsMRCrNH1kjzRTUJdRwUcufXXZ449ePwKke1m/q9KuCtQIe0bTPKrD55MoLU1k8fa9J0dH3tyPE5bB/zm7Oayt8s8LAG5jbukkkABztxK7jCKWB9ObXx0atfZ7yWnthBGI070IW3ojOKSVSlY4xKc8wm2ODuDRawmF6zMoowIDAQAB
-----END PUBLIC KEY-----
  ''';

  String encryptPassword(String input) {
    dynamic parser = RSAKeyParser().parse(_publicPem);
    final encrypt = Encrypter(RSA(publicKey: parser));
    return encrypt.encrypt(input).base64;
  }

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
