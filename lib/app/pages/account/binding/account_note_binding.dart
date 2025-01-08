import 'package:get/get.dart';

import '../controller/account_note_controller.dart';

class AccountNoteBinding extends Binding {
  @override
  List<Bind> dependencies() =>
      [Bind.lazyPut<AccountNoteController>(() => AccountNoteController())];
}
