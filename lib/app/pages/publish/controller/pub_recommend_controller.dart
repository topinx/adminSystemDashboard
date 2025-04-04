import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/pages.dart';
import 'package:top_back/app/widgets/note_drop_filter.dart';
import 'package:top_back/bean/bean_note_back.dart';
import 'package:top_back/bean/bean_search_user.dart';
import 'package:top_back/contants/http_constants.dart';
import 'package:top_back/network/request_mixin.dart';

class PubRecommendController extends GetxController with RequestMixin {
  String timeBegin = "";
  String timeEnd = "";

  /// 审核状态 0-未审核 1-通过 2-未通过 3-违规
  int? auditedStatus;

  /// 推荐状态 0-不推荐 1-推荐
  int? recommendedStatus;

  /// 笔记类型 1-图文 2-视频
  int? noteType;

  BeanSearchUser? user;

  TextEditingController inputSearch = TextEditingController();

  int pageNum = 1;

  int pageSize = 10;

  List<BeanNoteBack> beanList = [];
  int checkCnt = 0;

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

  void onTapCheck(BeanNoteBack bean) {
    Get.toNamed(Routes.NOTE_DETAIL(bean.noteId));
  }

  void onTapPublish(int type) {
    Get.toNamed(Routes.PUBLISH(BigInt.zero, type + 1));
  }

  Future<List<BeanSearchUser>> onSubmitUser(String string) async {
    return await requestUser(string);
  }

  void onSelectUser(BeanSearchUser? user) {
    user = user;
    onTapSearch();
  }

  void onFilterChange(NoteDropType type, int? tag) {
    switch (type) {
      case NoteDropType.tendency:
        break;
      case NoteDropType.limit:
        break;
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

  void onTimeChange(int i, String time) {
    if (i == 1) {
      timeBegin = time.isEmpty ? time : "$time 00:00:00";
      requestNoteCnt();
      requestNoteList();
    } else if (i == 2) {
      timeEnd = time.isEmpty ? time : "$time 23:59:59";
      requestNoteCnt();
      requestNoteList();
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
        "userId": user?.userId,
        "beginTime": timeBegin,
        "endTime": timeEnd,
        "auditedStatus": auditedStatus,
        "recommendedStatus": recommendedStatus,
        "noteType": noteType,
      },
      success: (data) => checkCnt = data,
    );
    update(["check-page"]);
  }

  Future<void> requestNoteList() async {
    BotToast.showLoading();
    await get(
      HttpConstants.noteListBack,
      param: {
        "pageNo": pageNum,
        "limit": pageSize,
        "userId": user?.userId,
        "beginTime": timeBegin,
        "endTime": timeEnd,
        "auditedStatus": auditedStatus,
        "recommendedStatus": recommendedStatus,
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
    beanList.addAll(tempList.map((x) => BeanNoteBack.fromJson(x)).toList());
    update(["check-table"]);
  }

  Future<List<BeanSearchUser>> requestUser(String nick) async {
    BotToast.showLoading();
    List<BeanSearchUser> result = [];
    await get(
      HttpConstants.searchUser,
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
