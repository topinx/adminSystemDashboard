import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:top_back/app/pages.dart';
import 'package:top_back/contants/app_storage.dart';

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

  void showToast(String msg) {}
}
