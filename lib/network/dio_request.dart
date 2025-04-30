import 'package:top_back/constants/app_constants.dart';
import 'package:top_back/network/token_interceptor.dart';
import 'package:top_back/router/router.dart';
import 'package:top_back/toast/toast.dart';
import 'package:dio/dio.dart';
import 'package:json_bigint/json_bigint.dart';

enum DioMethod { GET, POST, PUT }

class DioRequest {
  final Dio dio = Dio();

  DioRequest._() {
    dio.interceptors.add(TokenInterceptor(dio));
  }

  static final DioRequest _instance = DioRequest._();
  factory DioRequest() => _instance;

  final decSettings = DecoderSettings(
      whetherUseInt: (v) => v <= BigInt.parse('9007199254740991'));

  Future<dynamic> request(
    String path, {
    DioMethod method = DioMethod.GET,
    Map<String, dynamic>? query,
    Object? data,
    CancelToken? cancelToken,
  }) async {
    dio.options.baseUrl = AppConstants.httpLink;
    dio.options.method = method.name;
    dio.options.responseType = ResponseType.plain;

    try {
      Response response = await dio.request(
        path,
        queryParameters: query,
        data: data,
        cancelToken: cancelToken,
      );

      var jsonResponse = decodeJson(response.data, settings: decSettings)
          as Map<String, dynamic>;

      AppConstants.debugInfo({
        "path": response.requestOptions.uri,
        "header": response.requestOptions.headers,
        "method": response.requestOptions.method,
        "query": response.requestOptions.queryParameters,
        "data": response.requestOptions.data,
        "response": jsonResponse,
      });

      if (jsonResponse["code"] == 200) return jsonResponse["data"];
      _onRequestError(jsonResponse["code"], jsonResponse["errMsg"]);
      return null;
    } on DioException catch (error) {
      _onRequestError(-200, error.message ?? "");
      return null;
    } catch (error) {
      _onRequestError(-200, error.toString());
      return null;
    }
  }

  void _onRequestError(int code, String string) {
    Toast.showToast(string);

    if (code == 401 || code == 403) {
      router.go(RouterPath.path_login);
    }
  }
}
