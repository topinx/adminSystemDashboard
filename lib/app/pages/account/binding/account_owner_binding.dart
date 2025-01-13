import 'package:get/get.dart';

import '../controller/account_owner_controller.dart';

class AccountOwnerBinding extends Binding {
  @override
  List<Bind> dependencies() =>
      [Bind.lazyPut<AccountOwnerController>(() => AccountOwnerController())];
}
