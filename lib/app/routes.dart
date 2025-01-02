// ignore_for_file: non_constant_identifier_names

part of "pages.dart";

abstract class Routes {
  static const login = _Paths.login;
  static const home = _Paths.home;

  static const homeEmpty = home + _Paths.homeEmpty;

  static const accountManage = home + _Paths.accountManage;
  static const accountOwner = home + _Paths.accountOwner;

  Routes._();

  static String LOGIN_THEN(String after) =>
      '$login?then=${Uri.encodeQueryComponent(after)}';
}

abstract class _Paths {
  static const home = '/home';
  static const login = '/login';
  static const homeEmpty = '/homeEmpty';
  static const accountManage = '/accountManage';
  static const accountOwner = '/accountOwner';
}
