import 'package:get/get.dart';

import '../controller/pub_recommend_controller.dart';

class PubRecommendBinding extends Binding {
  @override
  List<Bind> dependencies() =>
      [Bind.lazyPut<PubRecommendController>(() => PubRecommendController())];
}
