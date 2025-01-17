import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/bean/bean_hot_search.dart';
import 'package:top_back/network/request_mixin.dart';

import '../widget/search_topic_create.dart';

class SearchTopicController extends GetxController with RequestMixin {
  TextEditingController inputSearch = TextEditingController();

  bool isAutoSort = true;
  bool isEditSort = false;

  List<BeanHotSearch> beanList = [];

  @override
  void onClose() {
    super.onClose();
    inputSearch.dispose();
  }

  void onTapSearch() {}

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
    update(["search-filter"]);
  }

  void onTapMultiDelete() {}

  void onTapSaveEdit() {
    isEditSort = false;
    update(["search-filter"]);
  }

  void onTapCancelEdit() {
    isEditSort = false;
    update(["search-filter"]);
  }

  void onSelectChanged(List<int> temp) {}
}
