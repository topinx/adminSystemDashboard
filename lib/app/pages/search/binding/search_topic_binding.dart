import 'package:get/get.dart';

import '../controller/search_topic_controller.dart';

class SearchTopicBinding extends Binding {
  @override
  List<Bind> dependencies() =>
      [Bind.lazyPut<SearchTopicController>(() => SearchTopicController())];
}
