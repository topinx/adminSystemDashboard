import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:top_back/app/pages.dart';
import 'package:top_back/bean/bean_note_detail.dart';
import 'package:top_back/contants/app_storage.dart';
import 'package:top_back/contants/http_constants.dart';
import 'package:top_back/network/request_mixin.dart';

class NoteDetailController extends GetxController with RequestMixin {
  BigInt noteId = BigInt.zero;

  BeanNoteDetail detail = BeanNoteDetail.empty();

  BigInt curNote = BigInt.zero;

  List<BigInt> recordNote = [];

  @override
  void onInit() {
    super.onInit();
    noteId = BigInt.tryParse(Get.parameters["id"] ?? "0") ?? BigInt.zero;
  }

  @override
  void onReady() {
    super.onReady();
    if (noteId == BigInt.zero) {
      // 从审核进入 可以连续审核
      requestNextNote();
    } else {
      // 从详情进入 只审核该笔记
      curNote = noteId;
      requestNoteDetail();
    }
  }

  Future<void> requestNextNote() async {
    BotToast.showLoading();

    await get(
      HttpConstants.nextAuditedNote,
      param: {"auditedBy": AppStorage().beanLogin.userId},
      success: onNoteDetail,
    );

    BotToast.closeAllLoading();
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
    if (data == null) return;
    detail = BeanNoteDetail.fromJson(data);
    curNote = detail.noteId;
    update();
  }

  Future<void> requestCheckNote() async {
    BotToast.showLoading();

    await post(
      HttpConstants.checkNote,
      param: {
        "noteId": "$curNote",
        "auditedStatus": detail.auditedStatus,
        "recommendedStatus": detail.recommendedStatus,
        "tendency": detail.tendency,
      },
      success: (data) {
        showToast("审核成功");
        update();
      },
    );

    BotToast.closeAllLoading();
  }

  Future<void> requestUpdateCheck() async {
    BotToast.showLoading();

    await post(
      HttpConstants.updateCheck,
      param: {
        "noteId": "$curNote",
        "auditedStatus": detail.auditedStatus,
        "recommendedStatus": detail.recommendedStatus,
        "tendency": detail.tendency,
      },
      success: (data) {
        showToast("修改审核成功");
        update();
      },
    );

    BotToast.closeAllLoading();
  }

  Future<void> requestDelete() async {
    BotToast.showLoading();

    await post(
      HttpConstants.deleteNote,
      param: {
        "noteIds": ["${detail.noteId}"]
      },
      success: (_) {
        showToast("已删除");
        Get.back();
      },
    );

    BotToast.closeAllLoading();
  }

  void onTapTendency(int tendency) {
    detail.tendency = tendency;
    update();
  }

  void onTapEdit() {
    if (detail.noteId == BigInt.zero) return;
    Get.toNamed(Routes.PUBLISH(detail.noteId, detail.noteType));
  }

  void onTapDelete() {
    requestDelete();
  }

  /// 上一篇
  void onTapPrev() {
    if (recordNote.isEmpty) {
      showToast("当前是第一篇");
      return;
    }
    if (recordNote.length == 1 && recordNote.first == curNote) {
      showToast("当前是第一篇");
      return;
    }

    recordNote.removeLast();
    curNote = recordNote.last;

    requestNoteDetail();
  }

  /// 下一篇
  void onTapNext() {
    if (!recordNote.contains(curNote)) {
      recordNote.add(curNote);
    }
    requestNextNote();
  }

  /// 审核通过 审核状态 0-未审核 1-通过 2-未通过 3-违规 推荐状态 0-不推荐 1-推荐
  void onTapPass() {
    if (detail.tendency < 1 || detail.tendency > 3) {
      showToast("请选择笔记偏好");
      return;
    }
    if (detail.auditedStatus == 0) {
      detail.auditedStatus = 1;
      detail.recommendedStatus = 0;
      detail.auditedBy = AppStorage().beanLogin.userId;
      detail.auditedNickname = AppStorage().beanLogin.nickname;

      requestCheckNote();
    } else {
      if (detail.auditedBy != AppStorage().beanLogin.userId) return;
      detail.auditedStatus = 1;
      detail.recommendedStatus = 0;
      detail.auditedBy = AppStorage().beanLogin.userId;
      detail.auditedNickname = AppStorage().beanLogin.nickname;

      requestUpdateCheck();
    }
  }

  /// 审核不通过
  void onTapUnPass() {
    if (detail.tendency < 1 || detail.tendency > 3) {
      showToast("请选择笔记偏好");
      return;
    }
    if (detail.auditedStatus == 0) {
      detail.auditedStatus = 2;
      detail.recommendedStatus = 0;
      detail.auditedBy = AppStorage().beanLogin.userId;
      detail.auditedNickname = AppStorage().beanLogin.nickname;

      requestCheckNote();
    } else {
      if (detail.auditedBy != AppStorage().beanLogin.userId) return;
      detail.auditedStatus = 2;
      detail.recommendedStatus = 0;
      detail.auditedBy = AppStorage().beanLogin.userId;
      detail.auditedNickname = AppStorage().beanLogin.nickname;

      requestUpdateCheck();
    }
  }

  /// 审核违规
  void onTapViolations() {
    if (detail.tendency < 1 || detail.tendency > 3) {
      showToast("请选择笔记偏好");
      return;
    }
    if (detail.auditedStatus == 0) {
      detail.auditedStatus = 3;
      detail.recommendedStatus = 0;
      detail.auditedBy = AppStorage().beanLogin.userId;
      detail.auditedNickname = AppStorage().beanLogin.nickname;

      requestCheckNote();
    } else {
      if (detail.auditedBy != AppStorage().beanLogin.userId) return;
      detail.auditedStatus = 3;
      detail.recommendedStatus = 0;
      detail.auditedBy = AppStorage().beanLogin.userId;
      detail.auditedNickname = AppStorage().beanLogin.nickname;

      requestUpdateCheck();
    }
  }

  /// 审核通过并推荐
  void onTapRecommend() {
    if (detail.tendency < 1 || detail.tendency > 3) {
      showToast("请选择笔记偏好");
      return;
    }
    if (detail.auditedStatus == 0) {
      detail.auditedStatus = 1;
      detail.recommendedStatus = 1;
      detail.auditedBy = AppStorage().beanLogin.userId;
      detail.auditedNickname = AppStorage().beanLogin.nickname;

      requestCheckNote();
    } else {
      if (detail.auditedBy != AppStorage().beanLogin.userId) return;
      detail.auditedStatus = 1;
      detail.recommendedStatus = 1;
      detail.auditedBy = AppStorage().beanLogin.userId;
      detail.auditedNickname = AppStorage().beanLogin.nickname;

      requestUpdateCheck();
    }
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
