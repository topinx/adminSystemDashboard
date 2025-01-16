import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchTopicCreateController extends GetxController {
  TextEditingController controller = TextEditingController();

  @override
  void onClose() {
    super.onClose();
    controller.dispose();
  }

  Future<List> onSubmitSearch(String string) async {
    return ["aa", "dd"];
  }

  void onSelectTopic(topic) {}
}
