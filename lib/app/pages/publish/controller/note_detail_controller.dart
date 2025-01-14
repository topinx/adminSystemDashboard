import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:top_back/bean/bean_note_detail.dart';
import 'package:top_back/contants/http_constants.dart';
import 'package:top_back/network/request_mixin.dart';

class NoteDetailController extends GetxController with RequestMixin {
  int noteId = 0;

  BeanNoteDetail detail = BeanNoteDetail.empty();

  int curNote = 0;

  @override
  void onInit() {
    super.onInit();
    noteId = int.tryParse(Get.parameters["id"] ?? "0") ?? 0;
  }

  @override
  void onReady() {
    super.onReady();
    if (noteId == 0) {
      // 从审核进入 可以连续审核
    } else {
      // 从详情进入 只审核该笔记
      curNote = noteId;
      requestNoteDetail();
    }
  }

  Future<void> requestNoteDetail() async {
    BotToast.showLoading();

    await get(
      HttpConstants.noteDetail,
      param: {"id": curNote},
      success: onNoteDetail,
    );

    BotToast.closeAllLoading();
  }

  void onNoteDetail(data) {
    detail = BeanNoteDetail.fromJson(data);
    update();
  }

  void onTapTendency(int tendency) {
    detail.tendency = tendency;
    update();
  }

  String getTopicList() {
    String topic = detail.topicList;
    if (topic.isEmpty) return "";
    List<String> topicList = json.decode(topic).toList().cast<String>();
    return topicList.join(" ");
  }

  String getContent() {
    String topic = detail.topicList;
    if (topic.isEmpty) return detail.textContent;

    List<String> topicList = json.decode(topic).toList().cast<String>();
    String content = detail.textContent;
    for (var t in topicList) {
      content = content.replaceFirst("$t^", t);
    }

    return content;
  }
}
