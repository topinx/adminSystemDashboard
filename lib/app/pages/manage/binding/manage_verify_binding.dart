import 'package:get/get.dart';

import '../controller/manage_verify_controller.dart';

class ManageVerifyBinding extends Binding {
  @override
  List<Bind> dependencies() =>
      [Bind.lazyPut<ManageVerifyController>(() => ManageVerifyController())];
}
