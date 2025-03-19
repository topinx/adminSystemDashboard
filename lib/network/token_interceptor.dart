import 'dart:async';

import 'package:dio/dio.dart';
import 'package:top_back/contants/app_storage.dart';
import 'package:top_back/contants/http_constants.dart';

import 'dio_response.dart';

class TokenInterceptor extends QueuedInterceptorsWrapper {
  final Dio client;
  TokenInterceptor(this.client);

  bool isRefreshing = false;
  final Dio tokenDio = Dio();
  final List<Completer<bool>> _tokenCompleter = [];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String token = "Bearer ${AppStorage().beanLogin.token}";
    options.headers['Authorization'] = token;
    options.headers['Accept-Language'] = "zh-CN";

    handler.next(options);
  }

  /// token过期异常拦截 需要置换新的token
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == DioResponse.codeExpired) {
      bool success = await refreshToken(err);

      if (success) {
        /// 重试原请求
        try {
          String token = "Bearer ${AppStorage().beanLogin.token}";
          err.requestOptions.headers['Authorization'] = token;

          final response = await tokenDio.fetch(err.requestOptions);
          handler.resolve(response);
        } catch (e) {
          handler.reject(err);
        }
      } else {
        handler.reject(err);
      }
    } else {
      handler.reject(err);
    }
  }

  Future<bool> refreshToken(DioException err) async {
    if (isRefreshing) {
      final completer = Completer<bool>();
      _tokenCompleter.add(completer);
      return completer.future;
    }

    isRefreshing = true;
    try {
      tokenDio.options.baseUrl = err.requestOptions.baseUrl;
      tokenDio.options.receiveTimeout = err.requestOptions.receiveTimeout;
      tokenDio.options.sendTimeout = err.requestOptions.sendTimeout;
      tokenDio.options.connectTimeout = err.requestOptions.connectTimeout;

      int username = AppStorage().beanLogin.userId;
      final response = await tokenDio.get(HttpConstants.refreshToken,
          queryParameters: {'userId': username});

      if (response.statusCode == 200) {
        AppStorage().updateUserToken(response.data["data"]);

        for (var completer in _tokenCompleter) {
          completer.complete(true);
        }
        _tokenCompleter.clear();

        return true;
      }
    } catch (e) {
      for (var completer in _tokenCompleter) {
        completer.completeError(e);
      }
      _tokenCompleter.clear();
    } finally {
      isRefreshing = false;
    }
    return false;
  }
}
