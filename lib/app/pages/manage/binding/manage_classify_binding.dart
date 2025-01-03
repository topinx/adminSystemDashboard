import 'package:get/get.dart';

import '../controller/manage_classify_controller.dart';

class ManageClassifyBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut<ManageClassifyController>(() => ManageClassifyController())
      ];
}
