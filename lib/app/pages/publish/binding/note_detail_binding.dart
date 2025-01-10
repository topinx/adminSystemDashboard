import 'package:get/get.dart';

import '../controller/note_detail_controller.dart';

class NoteDetailBinding extends Binding {
  @override
  List<Bind> dependencies() =>
      [Bind.lazyPut<NoteDetailController>(() => NoteDetailController())];
}
