import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/alert_dialog.dart';
import 'package:top_back/bean/bean_topic.dart';
import 'package:top_back/contants/http_constants.dart';
import 'package:top_back/network/request_mixin.dart';

import '../widget/manage_topic_edit.dart';

class ManageTopicController extends GetxController with RequestMixin {
  TextEditingController inputName = TextEditingController();

  String checkName = "";

  List<BeanTopic> beanList = [];
  int topicCnt = 0;

  int pageNum = 1;
  int pageSize = 10;
  List<BeanTopic> selectList = [];

  @override
  void onReady() {
    super.onReady();
    onTapSearch();
  }

  @override
  void onClose() {
    super.onClose();
    inputName.dispose();
  }

  void onTapSearch() {
    if (inputName.text != checkName) {
      pageNum = 1;
    }
    checkName = inputName.text;
    requestTopicCount();
    requestTopicList();
  }

  void onTapPage(int page) {
    pageNum = page;
    if (beanList.length - pageSize * (pageNum - 1) > 0) {
      update(["check-table"]);
    } else {
      requestTopicList();
    }
  }

  void onPageSizeChanged(int size) {
    pageSize = size;
    pageNum = 1;
    if (beanList.length - pageSize * (pageNum - 1) > 0) {
      update(["check-table"]);
    } else {
      requestTopicList();
    }
  }

  void onTapSelect(BeanTopic bean) {
    if (selectList.contains(bean)) {
      selectList.remove(bean);
    } else {
      selectList.add(bean);
    }
    update(["check-table"]);
  }

  void onTapSelectAll() {
    int start = (pageNum - 1) * pageSize;
    int end = start + pageSize;
    end = end > beanList.length ? beanList.length : end;

    if (selectList.length < end - start) {
      selectList = beanList.sublist(start, end);
    } else {
      selectList.clear();
    }
    update(["check-table"]);
  }

  void onTapCreate() {
    Get.dialog(const ManageTopicEdit());
  }

  void onTapEdit(BeanTopic topic) {
    Get.dialog(ManageTopicEdit(topic: topic));
  }

  void onTapDelete(BeanTopic topic) async {
    bool? accept = await Get.dialog(const Alert(title: "", content: "确认删除话题?"));
    if (accept != true) return;

    requestDelete([topic.id]);
  }

  void onMultiOperate(int value) async {
    if (selectList.isEmpty) {
      showToast("请先选择话题");
      return;
    }

    if (value == 0) {
      // 批量封禁
      requestModify(0);
    } else {
      // 批量删除
      bool? accept =
          await Get.dialog(const Alert(title: "", content: "确认删除话题?"));
      if (accept != true) return;

      await requestDelete(selectList.map((x) => x.id).toList());
      selectList.clear();
    }
  }

  Future<void> requestDelete(List<int> topics) async {
    BotToast.showLoading();
    await post(HttpConstants.topicDelete,
        param: json.encode(topics), success: onTopicDelete);
    BotToast.closeAllLoading();
  }

  void onTopicDelete(data) {
    showToast("已删除");
    requestTopicCount();
    requestTopicList();
  }

  Future<void> requestTopicList() async {
    BotToast.showLoading();
    await get(
      HttpConstants.topicList,
      param: {
        "pageNo": pageNum,
        "limit": pageSize,
        "name": checkName,
      },
      success: onTopicList,
    );
    BotToast.closeAllLoading();
  }

  void onTopicList(data) {
    pageNum = data["pageNo"];
    if (pageNum == 1) {
      beanList.clear();
    }
    List tempList = data["list"] ?? [];
    beanList.addAll(tempList.map((x) => BeanTopic.fromJson(x)).toList());
    update(["check-table"]);
  }

  void requestTopicCount() async {
    await get(
      HttpConstants.topicCnt,
      param: {"name": checkName},
      success: (data) => topicCnt = data,
    );

    update(["check-page"]);
  }

  Future<void> requestModify(int status) async {
    BotToast.showLoading();
    List topics = selectList.map((x) => x.id).toList();

    await post(
      HttpConstants.topicStatus,
      param: {
        "ids": topics,
        "status": status,
      },
      success: (data) {
        for (var topic in topics) {
          var bean1 = selectList.firstWhereOrNull((x) => x.id == topic);
          if (bean1 != null) {
            bean1.status = status;
          }
          var bean2 = beanList.firstWhereOrNull((x) => x.id == topic);
          if (bean2 != null) {
            bean2.status = status;
          }
        }
        update(["check-table"]);
      },
    );
    BotToast.closeAllLoading();
  }
}
