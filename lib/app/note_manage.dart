import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
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

  final sizeLimit = 3 * 1024 * 1024;

  final HomeController homeCtr = Get.find<HomeController>();

  Future<void> publishNote(BeanDraft draft) async {
    draftList.insert(0, draft);
    if (isLoading) return;
    startPublish();
  }

  Future<void> startPublish() async {
    if (draftList.isEmpty) return;

    isLoading = true;
    homeCtr.updatePub(true);

    BeanDraft draft = draftList.removeLast();
    for (var material in draft.materialList) {
      if (material.imgLink.isNotEmpty) continue;
      if (material.imgData == null) {
        showToast("资源不能为空");
        isLoading = false;
        homeCtr.updatePub(false);
        startPublish();
        return;
      }

      if (material.type == 1) {
        String name = getName(draft.createBy, material.imgName);
        String url = await upload(material.imgData!, name);
        material.imgLink = url;

        if (material.imgData!.lengthInBytes > sizeLimit) {
          Uint8List data = await FlutterImageCompress.compressWithList(
              material.imgData!,
              quality: 80);

          name = getName(draft.createBy, material.imgName);
          material.imgThumb = await upload(data, name);
        } else {
          material.imgThumb = url;
        }
      } else {
        String name = getName(draft.createBy, material.imgName);
        String url = await uploadVideo(material.imgData!, name);
        material.imgLink = url;
        material.imgThumb = url;
      }
    }

    if (draft.cover.imgLink.isEmpty) {
      if (draft.cover.imgData != null) {
        String name = getName(draft.createBy, draft.cover.imgName);
        String url = await upload(draft.cover.imgData!, name);

        if (url.isEmpty) {
          showToast("上传资源失败");
          isLoading = false;
          homeCtr.updatePub(false);
          startPublish();
          return;
        }

        draft.cover.imgLink = url;
        draft.cover.imgThumb = url;
      } else {
        draft.cover.imgLink = draft.materialList.first.imgThumb;
        draft.cover.imgThumb = draft.materialList.first.imgThumb;
      }
    }

    if (draft.noteId == 0) {
      await requestPub(draft);
    } else {
      await requestModify(draft);
    }
    isLoading = false;
    homeCtr.updatePub(false);
    startPublish();
  }

  String getName(int user, String path) {
    int dot = path.lastIndexOf(".");
    String suffix = path.substring(dot);
    return "note/$user/${DateTime.now().microsecondsSinceEpoch}$suffix";
  }

  Future<void> requestPub(BeanDraft draft) async {
    await post(
      HttpConstants.publish,
      param: {
        "cover": draft.cover.imgLink,
        "title": draft.title,
        "textContent": draft.textContent,
        "extra": "",
        "materialList": draft.materialList
            .map((x) => {"thumb": x.imgThumb, "url": x.imgLink, "type": x.type})
            .toList(),
        "noteType": draft.noteType,
        "tendency": draft.tendency,
        "status": draft.status,
        "topicList": draft.topicList,
        "createBy": draft.createBy
      },
      success: (_) => showToast("发布成功"),
    );
  }

  Future<void> requestModify(BeanDraft draft) async {}
}
