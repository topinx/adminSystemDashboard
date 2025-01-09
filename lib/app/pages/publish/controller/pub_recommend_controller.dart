import 'package:get/get.dart';
import 'package:top_back/app/pages.dart';

class PubRecommendController extends GetxController {
  void onTapPublish(int type) {
    Get.toNamed(Routes.PUBLISH(0, type));
  }
}
