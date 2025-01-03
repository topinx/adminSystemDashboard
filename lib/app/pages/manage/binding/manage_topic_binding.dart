import 'package:get/get.dart';

import '../controller/manage_topic_controller.dart';

class ManageTopicBinding extends Binding {
  @override
  List<Bind> dependencies() =>
      [Bind.lazyPut<ManageTopicController>(() => ManageTopicController())];
}
