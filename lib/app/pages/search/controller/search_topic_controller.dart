import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/widgets/alert_dialog.dart';
import 'package:top_back/bean/bean_hot_search.dart';
import 'package:top_back/contants/http_constants.dart';
import 'package:top_back/network/request_mixin.dart';

import '../widget/search_topic_create.dart';

class SearchTopicController extends GetxController with RequestMixin {
  TextEditingController inputSearch = TextEditingController();

  bool isAutoSort = true;
  bool isEditSort = false;

  List<BeanHotSearch> beanList = [];
  List<BeanHotSearch> selectList = [];

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
    requestHotSearchList();
  }

  void onChangeAutoSort(bool value) async {
    isAutoSort = value;
    update(["search-filter"]);

    await setSortType();
    requestHotSearchList();
  }

  void onTapCreate() {
    Get.dialog(const SearchTopicCreate());
  }

  void onTapEditSort() {
    if (isAutoSort) {
      showToast("自动排序模式下不可编辑");
      return;
    }
    isEditSort = true;
    update(["search-filter", "check-table"]);
  }

  void onTapMultiDelete() async {
    if (selectList.isEmpty) {
      showToast("请先选择话题");
      return;
    }

    bool? accept =
        await Get.dialog(const Alert(title: "", content: "确认删除热搜话题?"));
    if (accept != true) return;

    List<int> ids = selectList.map((x) => x.id).toList();
    requestDelete(ids);
    selectList.clear();
  }

  void onTapSaveEdit() {
    isEditSort = false;
    update(["search-filter", "check-table"]);
    requestSortList();
  }

  void onTapCancelEdit() {
    isEditSort = false;
    update(["search-filter"]);
    requestHotSearchList();
  }

  void onSelectChanged(List<int> temp) {
    selectList = temp.map((x) => beanList[x]).toList();
  }

  void onTapPinned(BeanHotSearch bean) {
    beanList.remove(bean);
    beanList.insert(0, bean);
    requestSortList();
    requestHotSearchList();
  }

  void onTapEdit(BeanHotSearch bean) {
    Get.dialog(SearchTopicCreate(id: bean.id));
  }

  void onTapDelete(BeanHotSearch bean) async {
    bool? accept =
        await Get.dialog(const Alert(title: "", content: "确认删除热搜话题?"));
    if (accept != true) return;

    requestDelete([bean.id]);
  }

  Future<void> requestDelete(List<int> topics) async {
    BotToast.showLoading();
    await post(HttpConstants.hotSearchDelete,
        param: json.encode(topics), success: onTopicDelete);
    BotToast.closeAllLoading();
  }

  void onTopicDelete(data) {
    showToast("已删除");
    requestHotSearchList();
  }

  Future<void> requestHotSearchList() async {
    BotToast.showLoading();
    await get(
      HttpConstants.hotSearchList,
      param: {},
      success: onHotSearchList,
    );
    BotToast.closeAllLoading();
  }

  void onHotSearchList(data) {
    List tempList = data["list"] ?? [];
    beanList = tempList.map((x) => BeanHotSearch.fromJson(x)).toList();
    checkCnt = beanList.length;
    isAutoSort = data["autoOrder"];
    update(["search-filter", "check-page", "check-table"]);
  }

  Future<void> requestSortList() async {
    List<int> topics = beanList.map((x) => x.id).toList();
    BotToast.showLoading();
    await post(HttpConstants.hotSearchSort, param: json.encode(topics));
    BotToast.closeAllLoading();
  }

  Future<void> setSortType() async {
    BotToast.showLoading();
    await post(HttpConstants.setHotSearchSort,
        param: {"autoOrder": isAutoSort});
    BotToast.closeAllLoading();
  }
}
