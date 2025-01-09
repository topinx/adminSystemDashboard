import 'package:get/get.dart';

import '../controller/manage_record_controller.dart';

class ManageRecordBinding extends Binding {
  @override
  List<Bind> dependencies() =>
      [Bind.lazyPut<ManageRecordController>(() => ManageRecordController())];
}
