import 'package:get/get.dart';

import '../controller/account_info_controller.dart';

class AccountInfoBinding extends Binding {
  @override
  List<Bind> dependencies() =>
      [Bind.lazyPut<AccountInfoController>(() => AccountInfoController())];
}
