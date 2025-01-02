import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/pages.dart';

class HomeController extends GetxController {
  List<Menu> menuList = [
    Menu()
      ..menuIcon = Icons.account_circle
      ..menuTxt = "账号管理"
      ..expand = false
      ..children = [
        Menu()
          ..menuTxt = "账号管理"
          ..menuRoute = Routes.accountManage,
        Menu()
          ..menuTxt = "我的账号"
          ..menuRoute = Routes.accountOwner
      ]
  ];
}

class Menu {
  String menuRoute = "";

  String menuTxt = "";

  bool expand = false;

  IconData menuIcon = Icons.account_circle;

  List<Menu> children = [];
}
