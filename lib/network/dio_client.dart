import 'package:dio/dio.dart';
import 'package:top_back/contants/app_constants.dart';

import 'dio_response.dart';
import 'token_interceptor.dart';

/// 成功回调 data
typedef DioCallbackS = Function(dynamic);

/// 失败回调 code errMsg
typedef DioCallbackE = Function(int, String);

class DioClient {
  final Dio request = Dio();

  static final DioClient _instance = DioClient._();

  factory DioClient() => _instance;

  DioClient._() {
    request.options.baseUrl = AppConstants.httpLink;

    request.options.connectTimeout = const Duration(minutes: 10);
    request.options.receiveTimeout = const Duration(minutes: 10);

    request.interceptors.addAll([TokenInterceptor(request)]);
  }

  /// http请求
  ///
  /// path 路径
  /// method 请求方式 GET POST...
  /// query / data 请求数据
  /// cancelToken 取消请求的token
  /// progressS / progressR 发送数据和接收数据的进度 progressS针对GET请求无效
  /// callbackS / callbackE 请求成功和失败的回调
  Future<void> doRequest(
    String path,
    String method, {
    Map<String, dynamic>? query,
    Object? data,
    CancelToken? cancelToken,
    ProgressCallback? progressS,
    ProgressCallback? progressR,
    DioCallbackS? callbackS,
    DioCallbackE? callbackE,
  }) async {
    request.options.method = method;
    try {
      Response result = await request.request(
        path,
        queryParameters: query,
        data: data,
        cancelToken: cancelToken,
        onSendProgress: progressS,
        onReceiveProgress: progressR,
      );
      decodeDioResponse(result, callbackS: callbackS, callbackE: callbackE);
    } catch (e) {
      decodeDioResponse(e, callbackS: callbackS, callbackE: callbackE);
    }
  }

  void decodeDioResponse(response,
      {DioCallbackS? callbackS, DioCallbackE? callbackE}) {
    DioResponse responseData = DioResponse.create(response);
    responseData.printResponse();

    if (responseData.code == DioResponse.codeSuccess) {
      if (callbackS != null) callbackS(responseData.data);
    } else if (responseData.code != DioResponse.codeCancelled) {
      if (callbackE != null) callbackE(responseData.code, responseData.msg);
    }
  }
}
