import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/pages.dart';
import 'package:top_back/app/widgets/note_drop_filter.dart';
import 'package:top_back/bean/bean_note_list.dart';
import 'package:top_back/contants/http_constants.dart';
import 'package:top_back/network/request_mixin.dart';

class AccountNoteController extends GetxController with RequestMixin {
  /// 审核状态 0-未审核 1-通过 2-未通过 3-违规
  int? auditedStatus;

  /// 偏好 1-男性 2-女性 3-综合
  int? tendency;

  /// 推荐状态 0-不推荐 1-推荐
  int? recommendedStatus;

  /// 可见范围 0-私密 1-公开 2-好友可见
  int? status;

  /// 笔记类型 1-图文 2-视频
  int? noteType;

  TextEditingController inputSearch = TextEditingController();

  int pageNum = 1;

  int pageSize = 10;

  List<BeanNoteList> beanList = [];
  int checkCnt = 0;

  int userId = 0;

  @override
  void onInit() {
    super.onInit();
    userId = int.parse(Get.parameters["userId"] ?? "0");
  }

  @override
  void onReady() {
    super.onReady();
    onTapSearch();
  }

  @override
  void onClose() {
    super.onClose();
    inputSearch.dispose();
  }

  void onTapSearch() {
    pageNum = 1;
    requestNoteCnt();
    requestNoteList();
  }

  void onTapCheck(BeanNoteList bean) {
    Get.toNamed(Routes.NOTE_DETAIL(bean.noteId));
  }

  void onFilterChange(NoteDropType type, int? tag) {
    switch (type) {
      case NoteDropType.tendency:
        {
          pageNum = 1;
          tendency = tag;
          requestNoteCnt();
          requestNoteList();
        }
      case NoteDropType.limit:
        {
          pageNum = 1;
          status = tag;
          requestNoteCnt();
          requestNoteList();
        }
      case NoteDropType.type:
        {
          pageNum = 1;
          noteType = tag;
          requestNoteCnt();
          requestNoteList();
        }
      case NoteDropType.audited:
        {
          pageNum = 1;
          auditedStatus = tag;
          requestNoteCnt();
          requestNoteList();
        }
      case NoteDropType.recommend:
        {
          pageNum = 1;
          recommendedStatus = tag;
          requestNoteCnt();
          requestNoteList();
        }
    }
  }

  void onTapPage(int page) {
    pageNum = page;
    if (beanList.length - pageSize * (pageNum - 1) > 0) {
      update(["check-table"]);
    } else {
      requestNoteList();
    }
  }

  void onPageSizeChanged(int size) {
    pageSize = size;
    pageNum = 1;
    if (beanList.length - pageSize * (pageNum - 1) > 0) {
      update(["check-table"]);
    } else {
      requestNoteList();
    }
  }

  Future<void> requestNoteCnt() async {
    await get(
      HttpConstants.noteCnt,
      param: {
        "createByList": [userId],
        "auditedStatus": auditedStatus,
        "tendency": tendency,
        "recommendedStatus": recommendedStatus,
        "status": status,
        "noteType": noteType,
      },
      success: (data) => checkCnt = data,
    );
    update(["check-page"]);
  }

  Future<void> requestNoteList() async {
    BotToast.showLoading();
    await get(
      HttpConstants.noteList,
      param: {
        "pageNo": pageNum,
        "limit": pageSize,
        "createByList": [userId],
        "auditedStatus": auditedStatus,
        "tendency": tendency,
        "recommendedStatus": recommendedStatus,
        "status": status,
        "noteType": noteType,
      },
      success: onNoteList,
    );
    BotToast.closeAllLoading();
  }

  void onNoteList(data) {
    pageNum = data["pageNo"];
    if (pageNum == 1) {
      beanList.clear();
    }
    List tempList = data["list"] ?? [];
    beanList.addAll(tempList.map((x) => BeanNoteList.fromJson(x)).toList());
    update(["check-table"]);
  }
}
