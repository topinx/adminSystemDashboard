import 'package:get/get.dart';

import '../controller/report_note_controller.dart';

class ReportNoteBinding extends Binding {
  @override
  List<Bind> dependencies() =>
      [Bind.lazyPut<ReportNoteController>(() => ReportNoteController())];
}
