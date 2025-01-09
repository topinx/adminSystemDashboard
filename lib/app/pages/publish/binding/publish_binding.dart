import 'package:get/get.dart';

import '../controller/publish_controller.dart';

class PublishBinding extends Binding {
  @override
  List<Bind> dependencies() =>
      [Bind.lazyPut<PublishController>(() => PublishController())];
}
