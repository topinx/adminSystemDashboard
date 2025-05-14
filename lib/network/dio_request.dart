import 'package:flutter/foundation.dart';
import 'package:top_back/constants/app_constants.dart';
import 'package:top_back/constants/http_constants.dart';
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

  Future<(List<String>, String)> signMedia(
      String objectName, int partNumber) async {
    try {
      var response = await request(
        HttpConstant.signMedia,
        query: {"objectName": objectName, "partNumber": partNumber},
      );
      List<String> partList = List<String>.from(response?["partPresign"] ?? []);
      String complete = response?["completePresign"] ?? "";

      return (partList, complete);
    } catch (_) {
      return (<String>[], "");
    }
  }

  Future<String> upload(Uint8List bytes, String objectName) async {
    int sizeT = bytes.length;
    int sizeC = 5 * 1024 * 1024;
    int chunkLen = (sizeT / sizeC).ceil();

    BaseOptions baseOptions = BaseOptions(
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
      sendTimeout: const Duration(minutes: 1),
    );
    Dio upDio = Dio(baseOptions);

    var signData = await signMedia(objectName, chunkLen);
    if (chunkLen == 1 && signData.$1.length != 1) return "";
    if (signData.$1.length != chunkLen && signData.$2.isEmpty) return "";

    try {
      if (chunkLen == 1) {
        var option = Options(headers: {
          'Content-Type': 'application/octet-stream',
          'Content-Length': sizeT.toString()
        });
        await upDio.put(signData.$1[0], data: bytes, options: option);
        return objectName;
      }

      List<Future<Map<String, dynamic>>> uploadTasks = [];
      List<Map<String, dynamic>> completed = [];
      int maxParts = 5;

      for (int index = 0; index < chunkLen; index++) {
        int start = index * sizeC;
        int end = (start + sizeC < sizeT) ? start + sizeC : sizeT;
        Uint8List chunk = bytes.sublist(start, end);

        if (uploadTasks.length >= maxParts) {
          completed.addAll(await Future.wait(uploadTasks));
          uploadTasks.clear();
        }
        uploadTasks
            .add(uploadChunk(upDio, signData.$1[index], chunk, index + 1));
      }

      if (uploadTasks.isNotEmpty) {
        completed.addAll(await Future.wait(uploadTasks));
      }
      final xmlParts = completed
          .map((part) =>
              '<Part><PartNumber>${part['part_number']}</PartNumber><ETag>${part['etag']}</ETag></Part>')
          .join('');

      final xmlBody = '<?xml version="1.0" encoding="UTF-8"?>'
          '<CompleteMultipartUpload>'
          '$xmlParts'
          '</CompleteMultipartUpload>';

      print("----------------合并分段");
      await upDio.post(signData.$2,
          data: xmlBody,
          options: Options(headers: {"Content-Type": "application/xml"}));
      return objectName;
    } catch (e) {
      return "";
    }
  }

  Future<Map<String, dynamic>> uploadChunk(
      Dio upDio, String url, Uint8List chunk, int index) async {
    print("----------------上传分段: $index");
    Response response = await upDio.put(
      url,
      data: chunk,
      options: Options(headers: {"Content-Type": "application/octet-stream"}),
    );

    String tag = response.headers['etag']!.first;
    return {"part_number": index, "etag": tag};
  }

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
