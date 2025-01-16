import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportUserController extends GetxController {
  TextEditingController inputSearch = TextEditingController();

  @override
  void onClose() {
    super.onClose();
    inputSearch.dispose();
  }

  void onTapSearch() {}
}
