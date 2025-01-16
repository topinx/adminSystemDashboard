import 'dart:typed_data';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_thumbnail_plus/flutter_video_thumbnail_plus.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_back/app/note_manage.dart';
import 'package:top_back/bean/bean_draft.dart';
import 'package:top_back/bean/bean_note_detail.dart';
import 'package:top_back/bean/bean_search_user.dart';
import 'package:top_back/contants/http_constants.dart';
import 'package:top_back/network/request_mixin.dart';

class PublishController extends GetxController with RequestMixin {
  int noteId = 0, noteType = 1;
  BeanDraft detail = BeanDraft();

  TextEditingController inputTitle = TextEditingController();
  TextEditingController inputContent = TextEditingController();
  TextEditingController inputTopic = TextEditingController();

  ImagePicker imagePicker = ImagePicker();

  BeanSearchUser? pubUser;

  @override
  void onInit() {
    super.onInit();
    noteId = int.parse(Get.parameters["id"] ?? "0");
    noteType = int.parse(Get.parameters["type"] ?? "1");
    detail.noteType = noteType;

    if (noteId != 0) {
      requestNoteDetail();
    }
  }

  @override
  void onClose() {
    super.onClose();
    inputTitle.dispose();
    inputContent.dispose();
    inputTopic.dispose();
  }

  void resetPubView() {
    pubUser = null;

    detail = BeanDraft();
    detail.noteType = noteType;
    update();

    inputTitle.clear();
    inputContent.clear();
    inputTopic.clear();
  }

  Future<List<BeanSearchUser>> onSubmitUser(String string) async {
    return await requestUser(string);
  }

  void onSelectUser(BeanSearchUser? user) {
    pubUser = user;
  }

  void onTapTendency(int tendency) {
    detail.tendency = tendency;
    update();
  }

  void onTapPub() {
    if (noteId == 0) {
      if (pubUser == null) {
        showToast("请输入发布用户");
        return;
      }
      detail.createBy = pubUser!.userId;
      detail.createByNickname = pubUser!.nickname;

      if (detail.materialList.isEmpty) {
        showToast("请选择资源");
        return;
      }
    }

    detail.title = inputTitle.text;
    detail.textContent = inputContent.text;

    String topics = inputTopic.text;
    if (topics.isNotEmpty) {
      List<String> topicList = RegExp(r'#([\w\u4e00-\u9fa5_-]+)')
          .allMatches(topics)
          .map((x) => "${x.group(0)} ")
          .toList();

      detail.updateTopic = topicList.join(" ") != detail.topicList.join(" ");
      detail.topicList = topicList;
      String topicStr = detail.topicList.map((x) => "$x^").toList().join(" ");
      detail.textContent += " $topicStr";
    }
    NoteManage().publishNote(detail);

    if (noteId == 0) {
      showToast("开始发布");
      resetPubView();
    } else {
      showToast("开始修改");
    }
  }

  void onTapAdd() async {
    if (detail.noteType == 1) {
      List<XFile> files = await imagePicker.pickMultiImage(
          limit: 18 - detail.materialList.length);

      for (var file in files) {
        DraftMaterial material = DraftMaterial();
        material.imgLink = "";
        material.imgName = file.name;
        material.imgData = await file.readAsBytes();
        detail.materialList.add(material);
      }

      detail.updateMaterial = true;
      update();
    } else {
      XFile? file = await imagePicker.pickVideo(
          source: ImageSource.gallery, maxDuration: const Duration(minutes: 3));
      if (file == null) return;

      DraftMaterial material = DraftMaterial();
      material.imgLink = "";
      material.imgName = file.name;
      material.imgData = await file.readAsBytes();
      detail.materialList.add(material);

      Uint8List? thumb = await FlutterVideoThumbnailPlus.thumbnailDataWeb(
        videoBytes: material.imgData!,
        quality: 80,
      );
      if (thumb != null) {
        detail.cover.imgLink = "";
        detail.cover.imgName =
            "${DateTime.now().millisecondsSinceEpoch}cover.jpg";
        detail.cover.imgData = thumb;
      }

      detail.updateMaterial = true;
      update();
    }
  }

  void onTapCover(DraftMaterial material) async {
    XFile? file = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 80);
    if (file == null) return;
    material.imgLink = "";
    material.imgName = file.name;
    material.imgData = await file.readAsBytes();
    update();
  }

  void onTapMaterial(DraftMaterial material) async {
    if (material.type == 1) {
      XFile? file = await imagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 80);
      if (file == null) return;
      material.imgLink = "";
      material.imgName = file.name;
      material.imgData = await file.readAsBytes();

      detail.updateMaterial = true;
      update();
    } else {
      XFile? file = await imagePicker.pickVideo(
          source: ImageSource.gallery, maxDuration: const Duration(minutes: 3));
      if (file == null) return;
      material.imgLink = "";
      material.imgName = file.name;
      material.imgData = await file.readAsBytes();

      Uint8List? thumb = await FlutterVideoThumbnailPlus.thumbnailDataWeb(
        videoBytes: material.imgData!,
        quality: 80,
      );
      if (thumb != null) {
        detail.cover.imgLink = "";
        detail.cover.imgName =
            "${DateTime.now().millisecondsSinceEpoch}cover.jpg";
        detail.cover.imgData = thumb;
      }

      detail.updateMaterial = true;
      update();
    }
  }

  bool canAddMaterial() {
    if (detail.noteType == 2) {
      if (detail.materialList.length == 1) return false;
    }
    if (detail.noteType == 1) {
      if (detail.materialList.length == 18) return false;
    }
    return true;
  }

  Future<void> requestNoteDetail() async {
    BotToast.showLoading();

    await get(
      HttpConstants.noteDetail,
      param: {"id": noteId},
      success: onNoteDetail,
    );

    BotToast.closeAllLoading();
  }

  void onNoteDetail(data) {
    if (data == null) return;
    BeanNoteDetail noteDetail = BeanNoteDetail.fromJson(data);
    detail = BeanDraft.fromNoteDetail(noteDetail);

    inputTitle.text = detail.title;
    inputContent.text = detail.textContent;
    inputTopic.text = detail.topicList.join(" ");

    update();
  }

  Future<List<BeanSearchUser>> requestUser(String nick) async {
    BotToast.showLoading();
    List<BeanSearchUser> result = [];
    await get(
      HttpConstants.searchAppUser,
      param: {"nickname": nick},
      success: (data) => result = data
          .map((x) => BeanSearchUser.fromJson(x))
          .toList()
          .cast<BeanSearchUser>(),
    );

    BotToast.closeAllLoading();
    return result;
  }
}
