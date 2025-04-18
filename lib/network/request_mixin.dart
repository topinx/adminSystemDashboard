import 'dart:typed_data';

import 'package:bot_toast/bot_toast.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/pages.dart';
import 'package:top_back/contants/app_constants.dart';
import 'package:top_back/contants/app_storage.dart';

import 'dio_client.dart';
import 'dio_response.dart';

mixin RequestMixin {
  Future get(
    String path, {
    Map<String, dynamic>? param,
    DioCallbackS? success,
    DioCallbackE? error,
  }) {
    return DioClient().doRequest(
      path,
      "GET",
      query: param,
      callbackS: success,
      callbackE: (code, msg) => _onResponseError(code, msg, error: error),
    );
  }

  Future post(
    String path, {
    Object? param,
    DioCallbackS? success,
    DioCallbackE? error,
  }) {
    return DioClient().doRequest(
      path,
      "POST",
      data: param,
      callbackS: success,
      callbackE: (code, msg) => _onResponseError(code, msg, error: error),
    );
  }

  void _onResponseError(int code, String msg, {DioCallbackE? error}) {
    if (code == DioResponse.codeNeedLogin || code == DioResponse.codeExpired) {
      showToast("登录已过期");

      AppStorage().clearUserInfo();
      if (Get.currentRoute == Routes.login) return;
      Get.toNamed(Routes.login);
    } else {
      showToast(msg);
      if (error != null) error(code, msg);
    }
  }

  Future<String> upload(Uint8List bytes, String folder, String name,
      [int? user, String? forceSuffix]) async {
    int time = DateTime.now().microsecondsSinceEpoch;
    int userId = user ?? AppStorage().beanLogin.userId;
    int dot = name.lastIndexOf(".");
    String suffix = forceSuffix ?? (name.substring(dot));
    String objectName = "$folder/$userId/$time$suffix";

    return DioClient().upload(bytes, objectName);
  }

  void showToast(String msg) {
    BotToast.showText(text: msg, align: Alignment.topCenter);
  }

  final String _publicPem = '''
-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC90FUsMRCrNH1kjzRTUJdRwUcufXXZ449ePwKke1m/q9KuCtQIe0bTPKrD55MoLU1k8fa9J0dH3tyPE5bB/zm7Oayt8s8LAG5jbukkkABztxK7jCKWB9ObXx0atfZ7yWnthBGI070IW3ojOKSVSlY4xKc8wm2ODuDRawmF6zMoowIDAQAB
-----END PUBLIC KEY-----
  ''';

  final String _publicLinePem = '''
-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCgQvkfgwcjbGDlE2tx3GqoNjKjYCyZPV/mf2GL285FPvbTE1XaLKLRaMnEk6ZLXCSRfYdU4xDy41VFwyNeowSnTlFC6V8RGj5bUtig7GaUbJ8hxocIVNF4IEo7lgdTYVpZFrtAwIn84dW4yTlHs96M4l9NtgfN4jhQW5HJZlW6pwIDAQAB
-----END PUBLIC KEY-----
  ''';

  String encryptPassword(String input) {
    String key =
        AppConstants.appEnv == AppEnv.onLine ? _publicLinePem : _publicPem;
    dynamic parser = RSAKeyParser().parse(key);
    final encrypt = Encrypter(RSA(publicKey: parser));
    return encrypt.encrypt(input).base64;
  }
}
