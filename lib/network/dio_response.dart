import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class DioResponse {
  /// 成功返回
  static const codeSuccess = 200;

  /// 鉴权过期
  static const codeExpired = 401;

  /// 鉴权无效
  static const codeNeedLogin = 403;

  /// 一般错误
  static const codeDefault = -200;

  /// 未知错误
  static const codeUnknown = -201;

  /// 请求取消
  static const codeCancelled = -201;

  /// 解析异常
  static const codeParseError = -202;

  final dynamic data;

  final int code;

  final String msg;

  final RequestOptions? options;

  DioResponse(this.code, this.msg, {this.data, this.options});

  factory DioResponse.create(response) {
    if (response is DioException) {
      switch (response.type) {
        case DioExceptionType.connectionTimeout:
          return DioResponse(codeDefault, "连接超时",
              options: response.requestOptions);
        case DioExceptionType.sendTimeout:
          return DioResponse(codeDefault, "发送超时",
              options: response.requestOptions);
        case DioExceptionType.receiveTimeout:
          return DioResponse(codeDefault, "接收超时",
              options: response.requestOptions);
        case DioExceptionType.cancel:
          return DioResponse(codeCancelled, "用户取消",
              options: response.requestOptions);
        case DioExceptionType.connectionError:
          return DioResponse(codeDefault, "网络连接错误",
              options: response.requestOptions);
        case DioExceptionType.unknown:
          return DioResponse(codeDefault, "未知错误",
              options: response.requestOptions);
        case DioExceptionType.badCertificate:
          return DioResponse(codeDefault, "验证错误",
              options: response.requestOptions);
        case DioExceptionType.badResponse:
          String errorStr = (response.response?.data ?? {}).toString();
          int errorCode = response.response?.statusCode ?? codeDefault;
          return DioResponse(errorCode,
              errorStr.isEmpty ? response.error.toString() : errorStr,
              options: response.requestOptions);
      }
    } else if (response is Response) {
      try {
        return DioResponse(response.data["code"], response.data["errMsg"],
            data: response.data["data"], options: response.requestOptions);
      } catch (e) {
        return DioResponse(codeParseError, e.toString(),
            data: response, options: response.requestOptions);
      }
    }
    return DioResponse(codeUnknown, response?.toString() ?? "未知错误");
  }

  void printResponse() {
    bool error = code != codeSuccess;
    var query = options?.data ?? options?.queryParameters;
    String path = (options?.baseUrl ?? "") + (options?.path ?? "");

    Map<String, dynamic> res = {
      "method": options?.method,
      "path": path,
      "query": query,
      "agent": options?.headers['UserAgent'],
      "token": options?.headers['Authorization'],
    };
    if (error) {
      res["error"] = "code=$code, msg=$msg";
      debugLog.e(res);
    } else {
      res["result"] = data;
      debugLog.i(res);
    }
  }

  var debugLog = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 0,
      lineLength: 120,
      colors: true,
      printEmojis: false,
      dateTimeFormat: DateTimeFormat.none,
    ),
  );
}
