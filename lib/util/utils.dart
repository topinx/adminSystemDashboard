import 'dart:async';
import 'dart:html' as html;

import 'package:flutter/foundation.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:top_back/bean/bean_image.dart';
import 'package:top_back/constants/app_storage.dart';
import 'package:top_back/router/router.dart';

class Utils {
  static String? onValidatorNick(String? string) {
    if (string == null || string.isEmpty) {
      return "昵称不可为空";
    }
    if (string.trim().length < 3 || string.trim().length > 30) {
      return "昵称长度3-30个字符";
    }

    return null;
  }

  static String? onValidatorPhone(String? string) {
    if (string == null || string.isEmpty) {
      return "手机不可为空";
    }
    if (!isPhoneNumber(string)) {
      return "请输入规范的手机号";
    }

    return null;
  }

  static String? onValidatorEmail(String? string) {
    if (string != null && string.isNotEmpty && !isEmail(string)) {
      return "请输入规范的邮箱地址";
    }

    return null;
  }

  static String? onValidatorPwd(String? string) {
    if (string == null || string.isEmpty) return "请输入密码";
    bool hasMatch = RegExp(r'[0-9a-zA-Z]').hasMatch(string);
    if (string.length < 6 || string.length > 18 || !hasMatch) {
      return "密码格式为6-18位的数字或字母,区分大小写";
    }
    return null;
  }

  static String? onValidatorEmpty(String? string) {
    if (string == null || string.isEmpty) return "请输入内容";
    return null;
  }

  static bool isEmail(String s) => hasMatch(s,
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  static bool isPhoneNumber(String s) {
    if (s.length > 16 || s.length < 9) return false;
    return hasMatch(s, r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
  }

  static bool isDateTime(String s) =>
      hasMatch(s, r'^\d{4}-\d{2}-\d{2}[ T]\d{2}:\d{2}:\d{2}.\d{3}Z?$');

  static bool hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }

  static int getAge(String birthday) {
    if (birthday.isEmpty) return 0;

    DateTime birthDate = DateTime.parse(birthday);
    DateTime today = DateTime.now();

    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  /// types 1: 图片 2: 视频
  static Future<List<XMLImage>> pickFile(
      {List<int> types = const [1], bool multiple = false}) {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();

    List<String> accept = [];
    if (types.contains(1)) {
      accept.add("image/*");
    }
    if (types.contains(2)) {
      accept.add("video/*");
    }

    uploadInput.accept = accept.join(',');
    uploadInput.multiple = multiple;
    uploadInput.click();

    final completer = Completer<List<XMLImage>>();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      if (files == null || files.isEmpty) {
        completer.complete([]);
        return;
      }

      final List<XMLImage> results = [];
      int imageCount = 0;

      for (final file in files) {
        final reader = html.FileReader();
        reader.readAsArrayBuffer(file);

        reader.onLoadEnd.listen((event) {
          final result = reader.result;
          if (result != null) {
            results.add(
                XMLImage(file.name, Uint8List.fromList(result as List<int>)));
          }

          imageCount++;
          if (imageCount == files.length) {
            completer.complete(results);
          }
        });
      }
    });
    return completer.future;
  }

  static Future<Uint8List?> onCropImage(XMLImage image) async {
    final blob = html.Blob([image.bytes]);
    final objectUrl = html.Url.createObjectUrlFromBlob(blob);

    final cropped = await ImageCropper().cropImage(
      sourcePath: objectUrl,
      uiSettings: [WebUiSettings(context: navigatorKey.currentContext!)],
    );

    html.Url.revokeObjectUrl(objectUrl);
    return await cropped?.readAsBytes();
  }

  static String objectName(String folder, String name,
      [int? user, String? forceSuffix]) {
    int time = DateTime.now().microsecondsSinceEpoch;
    int userId = user ?? Storage().user.userId;
    int dot = name.lastIndexOf(".");
    String suffix = forceSuffix ?? (name.substring(dot));
    return "$folder/$userId/$time$suffix";
  }
}
