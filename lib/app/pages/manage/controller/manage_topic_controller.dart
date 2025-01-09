import 'package:get/get.dart';

import '../widget/manage_topic_edit.dart';

class ManageTopicController extends GetxController {
  void onTapCreate() {
    Get.dialog(const ManageTopicEdit());
  }

  void onTapEdit() {}
}
