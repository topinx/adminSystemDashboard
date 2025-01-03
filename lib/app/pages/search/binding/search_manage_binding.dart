import 'package:get/get.dart';

import '../controller/search_manage_controller.dart';

class SearchManageBinding extends Binding {
  @override
  List<Bind> dependencies() =>
      [Bind.lazyPut<SearchManageController>(() => SearchManageController())];
}
