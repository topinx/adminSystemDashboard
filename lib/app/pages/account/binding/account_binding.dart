import 'package:get/get.dart';

import '../controller/account_manage_controller.dart';
import '../controller/account_owner_controller.dart';

class AccountBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        Bind.lazyPut<AccountManageController>(() => AccountManageController()),
        Bind.lazyPut<AccountOwnerController>(() => AccountOwnerController()),
      ];
}
