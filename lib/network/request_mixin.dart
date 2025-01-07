import 'dart:typed_data';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart' as dio;
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/pages.dart';
import 'package:top_back/contants/app_storage.dart';
import 'package:top_back/contants/http_constants.dart';

import 'dio_client.dart';
import 'dio_response.dart';

mixin RequestMixin {
  Future get(
    String path, {
    Map<String, dynamic>? param,
    dio.CancelToken? cancelToken,
    dio.ProgressCallback? progress,
    DioCallbackS? success,
    DioCallbackE? error,
  }) {
    return DioClient().doRequest(
      path,
      "GET",
      query: param,
      cancelToken: cancelToken,
      progressR: progress,
      callbackS: success,
      callbackE: (code, msg) => _onResponseError(code, msg, error: error),
    );
  }

  Future post(
    String path, {
    Object? param,
    dio.CancelToken? cancelToken,
    dio.ProgressCallback? progressS,
    dio.ProgressCallback? progressR,
    DioCallbackS? success,
    DioCallbackE? error,
  }) {
    return DioClient().doRequest(
      path,
      "POST",
      data: param,
      cancelToken: cancelToken,
      progressS: progressS,
      progressR: progressR,
      callbackS: success,
      callbackE: (code, msg) => _onResponseError(code, msg, error: error),
    );
  }

  Future put(
    String path, {
    Map<String, dynamic>? param,
    dio.CancelToken? cancelToken,
    dio.ProgressCallback? progress,
    DioCallbackS? success,
    DioCallbackE? error,
  }) {
    return DioClient().doRequest(
      path,
      "PUT",
      query: param,
      cancelToken: cancelToken,
      progressR: progress,
      callbackS: success,
      callbackE: (code, msg) => _onResponseError(code, msg, error: error),
    );
  }

  Future delete(
    String path, {
    Object? param,
    dio.CancelToken? cancelToken,
    dio.ProgressCallback? progress,
    DioCallbackS? success,
    DioCallbackE? error,
  }) {
    return DioClient().doRequest(
      path,
      "DELETE",
      data: param,
      cancelToken: cancelToken,
      progressR: progress,
      callbackS: success,
      callbackE: (code, msg) => _onResponseError(code, msg, error: error),
    );
  }

  Future<String> upload(Uint8List data, String name) async {
    var source = dio.MultipartFile.fromBytes(data, filename: name);

    String sourceLink = "";
    await post(
      HttpConstants.upload,
      param: dio.FormData.fromMap({"file": source}),
      success: (d) => sourceLink = d,
    );

    return sourceLink;
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

  void showToast(String msg) {
    BotToast.showText(text: msg, align: Alignment.topCenter);
  }

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
}
