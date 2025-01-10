import 'package:get/get.dart';

import '../controller/account_controller.dart';

class AccountBinding extends Binding {
  @override
  List<Bind> dependencies() {
    Bind.delete<AccountController>();
    return [Bind.put(AccountController())];
  }
}
