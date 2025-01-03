import 'package:get/get.dart';

import '../controller/report_user_controller.dart';

class ReportUserBinding extends Binding {
  @override
  List<Bind> dependencies() =>
      [Bind.lazyPut<ReportUserController>(() => ReportUserController())];
}
