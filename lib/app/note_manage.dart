import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:top_back/app/pages/home/controller/home_controller.dart';
import 'package:top_back/bean/bean_draft.dart';
import 'package:top_back/contants/http_constants.dart';
import 'package:top_back/network/request_mixin.dart';

class NoteManage with RequestMixin {
  static final NoteManage _instance = NoteManage._();
  NoteManage._();
  factory NoteManage() => _instance;

  bool isLoading = false;

  List<BeanDraft> draftList = [];

  final HomeController homeCtr = Get.find<HomeController>();

  Future<void> publishNote(BeanDraft draft) async {
    draftList.add(draft);
    startPublish();
  }

  void breakAndStartNext(BeanDraft draft) {
    showToast(draft.noteId == BigInt.zero ? "发布失败" : "修改失败");
    isLoading = false;
    homeCtr.updatePub(false, draft.noteId == BigInt.zero);
    startPublish();
  }

  void startNext(BeanDraft draft) {
    showToast(draft.noteId == BigInt.zero ? "发布成功" : "修改成功");
    isLoading = false;
    homeCtr.updatePub(false, draft.noteId == BigInt.zero);
    startPublish();
  }

  Future<void> startPublish() async {
    if (draftList.isEmpty || isLoading) return;

    isLoading = true;
    BeanDraft draft = draftList.removeAt(0);

    homeCtr.updatePub(true, draft.noteId == BigInt.zero);

    for (var material in draft.materialList) {
      if (material.imgLink.isNotEmpty) continue;
      if (material.imgData == null) return breakAndStartNext(draft);

      String imgLink = await upload(
          material.imgData!, "note", material.imgName, draft.createBy);
      if (imgLink.isEmpty) return breakAndStartNext(draft);
      material.imgLink = imgLink;

      if (material.thumbData != null) {
        String thumbLink = await upload(material.thumbData!, "note",
            material.imgName, draft.createBy, ".jpg");
        if (thumbLink.isEmpty) return breakAndStartNext(draft);
        material.imgThumb = thumbLink;
      }
    }

    if (draft.cover.imgData != null) {
      String imgLink = await upload(
          draft.cover.imgData!, "note", draft.cover.imgName, draft.createBy);
      if (imgLink.isEmpty) return breakAndStartNext(draft);
      draft.cover.imgLink = imgLink;
    }

    if (draft.cover.imgLink.isEmpty) {
      if (draft.noteType == 1) {
        draft.cover.imgLink = draft.materialList.first.imgLink;
      } else {
        draft.cover.imgLink = draft.materialList.first.imgThumb;
      }
    }

    if (draft.noteType == 1 &&
        draft.cover.imgLink != draft.materialList.first.imgLink) {
      draft.materialList.insert(0, draft.cover);
    }

    setDraftExtra(draft);

    if (draft.noteId == BigInt.zero) {
      await requestPub(draft);
    } else {
      await requestModify(draft);
    }
  }

  void setDraftExtra(BeanDraft draft) {
    var material = draft.materialList.first;

    if (material.type == 1 && material.imgData != null) {
      var input = MemoryInput(material.imgData!);
      final result = ImageSizeGetter.getSizeResult(input);

      Map<String, dynamic> extra = {};
      extra["frame_w"] = result.size.width;
      extra["frame_h"] = result.size.height;
      draft.extra = jsonEncode(extra);
    } else if (material.type == 2 && material.thumbData != null) {
      var input = MemoryInput(material.thumbData!);
      final result = ImageSizeGetter.getSizeResult(input);

      Map<String, dynamic> extra = {};
      extra["frame_w"] = result.size.width;
      extra["frame_h"] = result.size.height;
      draft.extra = jsonEncode(extra);
    }
  }

  Future<void> requestPub(BeanDraft draft) async {
    await post(
      HttpConstants.publish,
      param: {
        "cover": draft.cover.imgLink,
        "title": draft.title,
        "textContent": draft.textContent,
        "extra": draft.extra,
        "materialList": draft.materialList
            .map((x) => {"thumb": x.imgThumb, "url": x.imgLink, "type": x.type})
            .toList(),
        "noteType": draft.noteType,
        "tendency": draft.tendency,
        "status": draft.status,
        "topicList": draft.topicList,
        "createBy": draft.createBy,
        "classifyId": draft.classifyId,
        "position": draft.position,
        "location": draft.location,
      },
      success: (_) => startNext(draft),
      error: (_, __) => breakAndStartNext(draft),
    );
  }

  Future<void> requestModify(BeanDraft draft) async {
    await post(
      HttpConstants.updateNote,
      param: {
        "noteId": "${draft.noteId}",
        "cover": draft.cover.imgLink,
        "title": draft.title,
        "textContent": draft.textContent,
        "extra": draft.extra,
        "materialList": draft.materialList
            .map((x) => {"thumb": x.imgThumb, "url": x.imgLink, "type": x.type})
            .toList(),
        "noteType": draft.noteType,
        "tendency": draft.tendency,
        "status": draft.status,
        "updateMaterial": draft.updateMaterial,
        "updateTopic": draft.updateTopic,
        "topicList": draft.topicList
      },
      success: (_) => startNext(draft),
      error: (_, __) => breakAndStartNext(draft),
    );
  }
}
