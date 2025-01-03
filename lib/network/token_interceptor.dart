import 'dart:async';

import 'package:dio/dio.dart';
import 'package:top_back/contants/app_storage.dart';
import 'package:top_back/contants/http_constants.dart';

import 'dio_response.dart';

class TokenInterceptor extends QueuedInterceptorsWrapper {
  final Dio client;
  TokenInterceptor(this.client);

  bool isRefreshing = false;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String token = "Bearer ${AppStorage().beanLogin.token}";
    options.headers['Authorization'] = token;
    options.headers['Accept-Language'] = "zh-CN";

    super.onRequest(options, handler);
  }

  /// token过期异常拦截 需要置换新的token
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == DioResponse.codeExpired) {
      try {
        await refreshToken(err);

        /// 重试原请求
        final options = err.requestOptions;
        String token = "Bearer ${AppStorage().beanLogin.token}";
        options.headers['Authorization'] = token;

        final response = await client.fetch(options);
        handler.resolve(response);
      } catch (e) {
        handler.next(err);
      } finally {
        isRefreshing = false;
      }
    } else {
      handler.next(err);
    }
  }

  Future<void> refreshToken(DioException err) async {
    if (!isRefreshing) {
      isRefreshing = true;

      /// 创建一个新的Dio实例, 避免循环依赖
      Dio tokenDio = Dio();
      tokenDio.options.baseUrl = err.requestOptions.baseUrl;
      tokenDio.options.receiveTimeout = err.requestOptions.receiveTimeout;
      tokenDio.options.sendTimeout = err.requestOptions.sendTimeout;
      tokenDio.options.connectTimeout = err.requestOptions.connectTimeout;

      int username = AppStorage().beanLogin.userId;
      final response = await tokenDio.get(HttpConstants.refreshToken,
          queryParameters: {'userId': username});
      AppStorage().updateUserToken(response.data["data"]);
      isRefreshing = false;
    }
  }
}
