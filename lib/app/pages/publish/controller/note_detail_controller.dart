import 'package:get/get.dart';

class NoteDetailController extends GetxController {
  int noteId = 0;

  @override
  void onInit() {
    super.onInit();
    noteId = int.tryParse(Get.parameters["id"] ?? "0") ?? 0;
  }
}
