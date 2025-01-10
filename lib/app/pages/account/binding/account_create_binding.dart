import 'package:get/get.dart';

import '../controller/account_create_controller.dart';

class AccountCreateBinding extends Binding {
  @override
  List<Bind> dependencies() =>
      [Bind.lazyPut<AccountCreateController>(() => AccountCreateController())];
}
