import 'dart:async';
import 'package:top_back/constants/app_storage.dart';
import 'package:top_back/constants/http_constants.dart';
import 'package:dio/dio.dart';

class TokenInterceptor extends QueuedInterceptorsWrapper {
  final Dio client;
  TokenInterceptor(this.client);

  bool isRefreshing = false;
  final Dio tokenDio = Dio();
  final List<Completer<bool>> _tokenCompleter = [];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = Storage().bearToken;
    handler.next(options);
  }

  /// token过期异常拦截 需要置换新的token
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      bool success = await refreshToken(err);

      if (success) {
        try {
          String token = Storage().bearToken;
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
      int username = Storage().user.userId;
      final response = await tokenDio.get(HttpConstant.refreshToken,
          queryParameters: {'userId': username});

      if (response.statusCode == 200) {
        Storage().user.token = response.data["data"];
        Storage().saveUserToStorage();

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
