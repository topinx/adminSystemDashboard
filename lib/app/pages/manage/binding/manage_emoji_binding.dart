import 'package:get/get.dart';

import '../controller/manage_emoji_controller.dart';

class ManageEmojiBinding extends Binding {
  @override
  List<Bind> dependencies() =>
      [Bind.lazyPut<ManageEmojiController>(() => ManageEmojiController())];
}
