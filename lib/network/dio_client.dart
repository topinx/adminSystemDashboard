import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:top_back/contants/app_constants.dart';
import 'package:top_back/contants/http_constants.dart';

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

    request.options.connectTimeout = const Duration(hours: 1);
    request.options.receiveTimeout = const Duration(hours: 1);

    request.interceptors.addAll([TokenInterceptor(request)]);
  }

  Future<(List<String>, String, String)> signMedia(
      String objectName, int partNumber) async {
    List<String> partList = [];
    String complete = "", uploadId = "";

    await doRequest(
      HttpConstants.signMedia,
      "GET",
      query: {"objectName": objectName, "partNumber": partNumber},
      callbackS: (data) {
        partList = List<String>.from(data?["partPresign"] ?? []);
        complete = data?["completePresign"] ?? "";
      },
    );
    return (partList, complete, uploadId);
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
      for (int index = 0; index < chunkLen; index++) {
        int start = index * sizeC;
        int end = (start + sizeC < sizeT) ? start + sizeC : sizeT;
        Uint8List chunk = bytes.sublist(start, end);

        uploadTasks
            .add(uploadChunk(upDio, signData.$1[index], chunk, index + 1));
      }

      List<Map<String, dynamic>> completed = await Future.wait(uploadTasks);
      final xmlParts = completed
          .map((part) =>
              '<Part><PartNumber>${part['part_number']}</PartNumber><ETag>${part['etag']}</ETag></Part>')
          .join('');

      final xmlBody = '<?xml version="1.0" encoding="UTF-8"?>'
          '<CompleteMultipartUpload>'
          '$xmlParts'
          '</CompleteMultipartUpload>';

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
    Response response = await upDio.put(
      url,
      data: chunk,
      options: Options(headers: {"Content-Type": "application/octet-stream"}),
    );

    String tag = response.headers['etag']!.first;
    return {"part_number": index, "etag": tag};
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
    DioCallbackS? callbackS,
    DioCallbackE? callbackE,
  }) async {
    try {
      request.options.method = method;
      Response result = await request.request(
        path,
        queryParameters: query,
        data: data,
        cancelToken: cancelToken,
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
