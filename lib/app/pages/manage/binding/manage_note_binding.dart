import 'package:get/get.dart';

import '../controller/manage_note_controller.dart';

class ManageNoteBinding extends Binding {
  @override
  List<Bind> dependencies() =>
      [Bind.lazyPut<ManageNoteController>(() => ManageNoteController())];
}
