import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/contants/http_constants.dart';
import 'package:top_back/network/request_mixin.dart';

import '../widget/manage_topic_edit.dart';

class ManageTopicController extends GetxController with RequestMixin {
  TextEditingController inputName = TextEditingController();

  String checkName = "";

  List beanList = [];
  int topicCnt = 0;

  int pageNum = 1;
  int pageSize = 10;

  @override
  void onClose() {
    super.onClose();
    inputName.dispose();
  }

  void onTapSearch() {
    if (inputName.text != checkName) {
      pageNum = 1;
    }
    requestTopicList();
  }

  void onTapPage(int page) {
    pageNum = page;
    if ((pageNum - 1) * pageSize <= beanList.length) {
      update(["check-table"]);
    } else {
      requestTopicList();
    }
  }

  void onPageSizeChanged(int size) {
    pageSize = size;
    pageNum = 1;
    if (pageNum * pageSize <= beanList.length) {
      update(["check-table"]);
    } else {
      requestTopicList();
    }
  }

  void onTapCreate() {
    Get.dialog(const ManageTopicEdit());
  }

  void onTapEdit() {}

  Future<void> requestTopicList() async {
    BotToast.showLoading();
    await get(
      HttpConstants.topicList,
      param: {
        "pageNo": pageNum,
        "limit": pageSize,
        "name": checkName,
      },
    );
    BotToast.closeAllLoading();
  }

  void requestTopicCount({bool all = false}) async {
    await get(
      HttpConstants.accountCnt,
      param: {"name": checkName},
      success: (data) => topicCnt = data,
    );

    update(["check-page"]);
  }
}
