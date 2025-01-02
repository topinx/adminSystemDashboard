import 'package:get/get.dart';

import 'auth_middleware.dart';
import 'pages/account/index.dart';
import 'pages/login/index.dart';
import 'pages/home/index.dart';

part 'routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      preventDuplicates: true,
      participatesInRootNavigator: true,
      name: _Paths.home,
      transition: Transition.fadeIn,
      page: () => const HomePage(),
      binding: HomeBinding(),
      middlewares: [AuthMiddleware()],
      children: [
        GetPage(
          name: _Paths.accountManage,
          transition: Transition.fadeIn,
          page: () => const AccountManageView(),
          binding: AccountManageBinding(),
        ),
        GetPage(
          name: _Paths.accountOwner,
          transition: Transition.fadeIn,
          page: () => const AccountOwnerView(),
          binding: AccountOwnerBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.login,
      transition: Transition.fadeIn,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
  ];
}
