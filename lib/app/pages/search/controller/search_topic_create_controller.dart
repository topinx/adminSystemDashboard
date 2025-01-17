import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/bean/bean_topic.dart';
import 'package:top_back/contants/http_constants.dart';
import 'package:top_back/network/request_mixin.dart';

class SearchTopicCreateController extends GetxController with RequestMixin {
  TextEditingController inputTitle = TextEditingController();
  TextEditingController inputTopic = TextEditingController();
  TextEditingController inputOrder = TextEditingController();

  BeanTopic? beanTopic;

  @override
  void onClose() {
    super.onClose();
    inputTitle.dispose();
    inputTopic.dispose();
    inputOrder.dispose();
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

    bool success = await requestCreate();
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
      },
      success: (_) => success = true,
    );

    BotToast.closeAllLoading();
    return success;
  }
}
