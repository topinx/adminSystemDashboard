import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  void onChangeAutoSort(bool value) {
    isAutoSort = value;
    update(["search-filter"]);
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

  void onTapMultiDelete() {
    if (selectList.isEmpty) {
      showToast("请先选择话题");
      return;
    }
  }

  void onTapSaveEdit() {
    isEditSort = false;
    update(["search-filter", "check-table"]);
  }

  void onTapCancelEdit() {
    isEditSort = false;
    update(["search-filter", "check-table"]);
  }

  void onSelectChanged(List<int> temp) {
    selectList = temp.map((x) => beanList[x]).toList();
  }

  void onTapPinned(BeanHotSearch bean) {}

  void onTapEdit(BeanHotSearch bean) {}

  void onTapDelete(BeanHotSearch bean) {}

  Future<void> requestHotSearchList() async {
    BotToast.showLoading();
    await get(HttpConstants.hotSearchList, param: {}, success: onHotSearchList);
    BotToast.closeAllLoading();
  }

  void onHotSearchList(data) {
    List tempList = data ?? [];
    beanList = tempList.map((x) => BeanHotSearch.fromJson(x)).toList();
    update(["check-table"]);
  }
}
