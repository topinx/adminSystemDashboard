import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_thumbnail_plus/flutter_video_thumbnail_plus.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_back/app/note_manage.dart';
import 'package:top_back/app/pages/publish/widget/pub_create_sheet.dart';
import 'package:top_back/bean/bean_draft.dart';
import 'package:top_back/bean/bean_note_detail.dart';
import 'package:top_back/bean/bean_search_user.dart';
import 'package:top_back/contants/http_constants.dart';
import 'package:top_back/network/request_mixin.dart';

class PublishController extends GetxController with RequestMixin {
  BigInt noteId = BigInt.zero;
  int noteType = 1;
  BeanDraft detail = BeanDraft();

  TextEditingController inputTitle = TextEditingController();
  TextEditingController inputContent = TextEditingController();
  TextEditingController inputTopic = TextEditingController();
  TextEditingController inputNick = TextEditingController();

  ImagePicker imagePicker = ImagePicker();

  BeanSearchUser? pubUser;

  /// 创意中心分类
  int? classifyId;

  /// 创意中心分类列表
  List<String> createList = [];

  @override
  void onClose() {
    super.onClose();
    inputTitle.dispose();
    inputContent.dispose();
    inputTopic.dispose();
    inputNick.dispose();
  }

  void resetPubView() {
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
    if (noteId == BigInt.zero) {
      if (pubUser == null) {
        showToast("请输入发布用户");
        return;
      }
      detail.createBy = pubUser!.userId;
      detail.createByNickname = pubUser!.nickname;

      detail.classifyId = classifyId;
    }

    if (detail.materialList.isEmpty) {
      showToast("请选择资源");
      return;
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

    if (noteId == BigInt.zero) {
      showToast("开始发布");
      resetPubView();
    } else {
      showToast("开始修改");
    }
  }

  void onTapCreateType() async {
    var current = await Get.bottomSheet(
        PubCreateSheet(createList: createList, classifyId: classifyId));
    if (current == null) return;
    classifyId = current == -1 ? null : current;
    update();
  }

  void onTapAdd() async {
    BotToast.showLoading();

    if (detail.noteType == 1) {
      List<XFile> files = await imagePicker.pickMultiImage();
      int limit = 18 - detail.materialList.length;
      if (files.length > limit) {
        files = files.sublist(0, limit);
      }

      for (var file in files) {
        DraftMaterial material = DraftMaterial();
        material.type = 1;
        material.imgLink = "";
        material.imgName = file.name;
        material.imgData = await file.readAsBytes();
        detail.materialList.add(material);
      }

      detail.updateMaterial = true;
      update();
    } else {
      XFile? file = await imagePicker.pickVideo(source: ImageSource.gallery);
      if (file == null) return BotToast.closeAllLoading();

      DraftMaterial material = DraftMaterial();
      material.type = 2;
      material.imgLink = "";
      material.imgName = file.name;
      material.imgData = await file.readAsBytes();

      material.thumbData = await FlutterVideoThumbnailPlus.thumbnailDataWeb(
        videoBytes: material.imgData!,
        quality: 80,
      );
      detail.materialList.add(material);

      detail.updateMaterial = true;
      update();
    }

    BotToast.closeAllLoading();
  }

  void onTapCover(DraftMaterial material) async {
    XFile? file = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 80);
    if (file == null) return;
    material.type = 1;
    material.imgLink = "";
    material.imgName = file.name;
    material.imgData = await file.readAsBytes();
    update();
  }

  void onDeleteMaterial(DraftMaterial material) {
    detail.materialList.remove(material);

    detail.updateMaterial = true;
    update();
  }

  void onTapMaterial(DraftMaterial material) async {
    BotToast.showLoading();

    if (material.type == 1) {
      XFile? file = await imagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 80);
      if (file == null) return BotToast.closeAllLoading();
      material.imgLink = "";
      material.imgName = file.name;
      material.imgData = await file.readAsBytes();

      detail.updateMaterial = true;
      update();
    } else {
      XFile? file = await imagePicker.pickVideo(source: ImageSource.gallery);
      if (file == null) return BotToast.closeAllLoading();
      material.imgLink = "";
      material.imgName = file.name;
      material.imgData = await file.readAsBytes();

      material.thumbData = await FlutterVideoThumbnailPlus.thumbnailDataWeb(
        videoBytes: material.imgData!,
        quality: 80,
      );

      detail.updateMaterial = true;
      update();
    }

    BotToast.closeAllLoading();
  }

  Future<void> requestNoteDetail() async {
    BotToast.showLoading();

    await get(
      HttpConstants.noteDetail,
      param: {"id": noteId},
      success: onNoteDetail,
    );

    BotToast.closeAllLoading();

    if (noteId == BigInt.zero) {
      inputNick.text = pubUser?.nickname ?? "";
    } else {
      inputNick.text = detail.createByNickname;
    }
  }

  Future<void> requestCreateList() async {
    await get(HttpConstants.createCenterList, success: onCreateCenterList);
  }

  void onCreateCenterList(data) {
    createList = List<String>.from(data ?? []);
    update();
  }

  void onNoteDetail(data) {
    if (data == null) return;
    BeanNoteDetail noteDetail = BeanNoteDetail.fromJson(data);
    detail = BeanDraft.fromNoteDetail(noteDetail);
    if (noteDetail.cover.isNotEmpty && noteDetail.noteType == 2) {
      var draftCover = DraftMaterial()..imgLink = noteDetail.cover;
      detail.cover = draftCover;
    }

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
