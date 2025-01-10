import 'package:get/get.dart';

class PublishController extends GetxController {
  int noteId = 0;
  int noteType = 1;

  @override
  void onInit() {
    super.onInit();

    noteId = int.parse(Get.parameters["id"] ?? "0");
    noteType = int.parse(Get.parameters["type"] ?? "1");
  }
}
