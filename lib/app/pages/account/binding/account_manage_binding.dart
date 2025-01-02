import 'package:get/get.dart';

import '../controller/account_manage_controller.dart';

class AccountManageBinding extends Binding {
  @override
  List<Bind> dependencies() =>
      [Bind.lazyPut<AccountManageController>(() => AccountManageController())];
}
