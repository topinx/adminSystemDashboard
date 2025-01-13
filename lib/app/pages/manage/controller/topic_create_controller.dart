import 'dart:typed_data';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_back/bean/bean_topic.dart';
import 'package:top_back/contants/http_constants.dart';
import 'package:top_back/network/request_mixin.dart';

class TopicCreateController extends GetxController with RequestMixin {
  BeanTopic? topic;

  TextEditingController inputName = TextEditingController();

  ImagePicker imagePicker = ImagePicker();

  String fileCoverName = "";
  Uint8List? dataCover;

  int status = 1;

  @override
  void onInit() {
    super.onInit();
    status = topic?.status ?? 1;
  }

  @override
  void onReady() {
    super.onReady();
    inputName.text = topic?.name ?? "";
  }

  @override
  void onClose() {
    super.onClose();
    inputName.dispose();
  }

  void onTapCover() async {
    XFile? file = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
      maxHeight: 800,
      imageQuality: 80,
    );
    if (file == null) return;
    fileCoverName = file.name;
    dataCover = await file.readAsBytes();
    update();
  }

  void onTapBan() {
    status = 0;
    update();
  }

  void onTapUnban() {
    status = 1;
    update();
  }

  Future<bool> onTapConfirm() async {
    if (topic == null) {
      inputName.text = inputName.text.trimRight();
      if (!inputName.text.endsWith(" ")) {
        inputName.text += " ";
      }
      if (!checkTopic()) {
        showToast("请输入正确的话题");
        return false;
      }
      if (dataCover == null) {
        showToast("请设置话题封面");
        return false;
      }
      return await requestCreate();
    } else {
      inputName.text = inputName.text.trimRight();
      if (!inputName.text.endsWith(" ")) {
        inputName.text += " ";
      }
      if (!checkTopic()) {
        showToast("请输入正确的话题");
        return false;
      }

      return await requestEdit();
    }
  }

  bool checkTopic() {
    if (inputName.text.length < 3) return false;
    List<Match> match = RegExp(r"#[^#]").allMatches(inputName.text).toList();
    if (match.isEmpty || match.length > 1) return false;
    if (match[0].start != 0) return false;
    return true;
  }

  Future<bool> requestCreate() async {
    BotToast.showLoading();

    String name =
        "topic/${DateTime.now().millisecondsSinceEpoch}/$fileCoverName";
    String image = await upload(dataCover!, name);
    if (image.isEmpty) {
      BotToast.closeAllLoading();
      return false;
    }

    bool success = false;
    await post(
      HttpConstants.topicCreate,
      param: {"name": inputName.text, "avatar": image},
      success: (_) => success = true,
    );

    BotToast.closeAllLoading();
    if (success) {
      showToast("创建成功");
    }
    return success;
  }

  Future<bool> requestEdit() async {
    BotToast.showLoading();

    Map<String, dynamic> param = {
      "id": topic!.id,
      "name": inputName.text,
      "status": status,
    };

    if (dataCover != null && fileCoverName.isNotEmpty) {
      String name =
          "topic/${DateTime.now().millisecondsSinceEpoch}/$fileCoverName";
      String image = await upload(dataCover!, name);
      if (image.isNotEmpty) param.addEntries({"avatar": image}.entries);
    }

    bool success = false;
    await post(
      HttpConstants.topicEdit,
      param: param,
      success: (_) => success = true,
    );

    BotToast.closeAllLoading();
    if (success) {
      showToast("编辑成功");
    }
    return success;
  }
}
