import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/bean/bean_hot_search.dart';
import 'package:top_back/bean/bean_topic.dart';
import 'package:top_back/contants/http_constants.dart';
import 'package:top_back/network/request_mixin.dart';

class SearchTopicCreateController extends GetxController with RequestMixin {
  TextEditingController inputTitle = TextEditingController();
  TextEditingController inputTopic = TextEditingController();
  TextEditingController inputOrder = TextEditingController();
  TextEditingController inputDescr = TextEditingController();

  BeanTopic? beanTopic;

  int searchId = 0;

  @override
  void onReady() {
    super.onReady();
    requestInfo();
  }

  @override
  void onClose() {
    super.onClose();
    inputTitle.dispose();
    inputTopic.dispose();
    inputOrder.dispose();
    inputDescr.dispose();
  }

  Future<List<BeanTopic>> onSubmitSearch(String string) async {
    return await requestTopic(string);
  }

  void onSelectTopic(BeanTopic? topic) {
    beanTopic = topic;
  }

  Future<bool> onTapConfirm() async {
    if (inputTitle.text.trim().isEmpty) {
      showToast("请输入热搜标题");
      return false;
    }

    if (beanTopic == null) {
      showToast("请选择关联话题");
      return false;
    }

    if (inputDescr.text.trim().isEmpty) {
      showToast("请输入热搜导语");
      return false;
    }

    bool success = false;
    if (searchId == 0) {
      success = await requestCreate();
      if (success) showToast("创建成功");
    } else {
      success = await requestUpdate();
      if (success) showToast("更新成功");
    }

    return success;
  }

  Future<List<BeanTopic>> requestTopic(String nick) async {
    BotToast.showLoading();
    List<BeanTopic> result = [];

    await get(
      HttpConstants.topicList,
      param: {"pageNo": 1, "limit": 20, "name": nick},
      success: (data) {
        List tempList = data["list"] ?? [];
        result = tempList.map((x) => BeanTopic.fromJson(x)).toList();
      },
    );

    BotToast.closeAllLoading();
    return result;
  }

  Future<bool> requestCreate() async {
    bool success = false;
    BotToast.showLoading();

    int? order = int.tryParse(inputOrder.text);
    if (order != null && order < 1) {
      order = null;
    }

    await post(
      HttpConstants.createHotSearch,
      param: {
        "title": inputTitle.text,
        "topicId": beanTopic!.id,
        "topicName": beanTopic!.name,
        "orderId": order,
        "introduction": inputDescr.text,
      },
      success: (_) => success = true,
    );

    BotToast.closeAllLoading();
    return success;
  }

  Future<void> requestInfo() async {
    if (searchId == 0) return;

    BotToast.showLoading();
    await get(HttpConstants.hotSearchInfo,
        param: {"id": searchId}, success: onHotSearchInfo);
    BotToast.closeAllLoading();
  }

  void onHotSearchInfo(data) {
    BeanHotSearch hotSearch = BeanHotSearch.fromJson(data);
    inputTitle.text = hotSearch.title;
    inputTopic.text = hotSearch.topicName;
    inputOrder.text = "${hotSearch.orderId}";
    inputDescr.text = hotSearch.introduction;

    beanTopic = BeanTopic(
      id: hotSearch.topicId,
      name: hotSearch.topicName,
      avatar: "",
      noteCnt: 0,
      status: 0,
      createTime: "",
      topSearch: null,
    );
  }

  Future<bool> requestUpdate() async {
    bool success = false;
    BotToast.showLoading();

    int? order = int.tryParse(inputOrder.text);
    if (order != null && order < 1) {
      order = null;
    }

    await post(
      HttpConstants.updateHotSearch,
      param: {
        "id": searchId,
        "title": inputTitle.text,
        "topicId": beanTopic!.id,
        "topicName": beanTopic!.name,
        "orderId": order,
        "introduction": inputDescr.text,
      },
      success: (_) => success = true,
    );

    BotToast.closeAllLoading();
    return success;
  }
}
