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
      bindings: [HomeBinding()],
      children: [
        GetPage(
          name: _Paths.homeEmpty,
          transition: Transition.fadeIn,
          page: () => const HomeEmpty(),
        ),
        GetPage(
          name: _Paths.accountManage,
          transition: Transition.fadeIn,
          page: () => const AccountManage(),
          middlewares: [AuthMiddleware()],
        ),
        GetPage(
          name: _Paths.accountOwner,
          transition: Transition.fadeIn,
          page: () => const AccountOwner(),
          middlewares: [AuthMiddleware()],
        ),
      ],
    ),
    GetPage(
      name: _Paths.login,
      opaque: false,
      transition: Transition.fadeIn,
      page: () => const LoginPage(),
      bindings: [LoginBinding()],
    ),
  ];
}
