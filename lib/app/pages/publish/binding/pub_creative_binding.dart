import 'package:get/get.dart';

import '../controller/pub_creative_controller.dart';

class PubCreativeBinding extends Binding {
  @override
  List<Bind> dependencies() =>
      [Bind.lazyPut<PubCreativeController>(() => PubCreativeController())];
}
