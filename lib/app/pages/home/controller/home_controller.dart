import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/pages.dart';
import 'package:top_back/bean/bean_menu.dart';
import 'package:top_back/contants/http_constants.dart';
import 'package:top_back/network/request_mixin.dart';

class HomeController extends GetxController with RequestMixin {
  Map<int, Menu> routeMap = {
    1: Menu()
      ..menuIcon = Icons.account_circle
      ..menuTxt = "账号管理"
      ..menuId = 1
      ..menuRoute = "",
    2: Menu()
      ..menuIcon = Icons.add
      ..menuTxt = "账号管理"
      ..menuId = 2
      ..menuRoute = Routes.accountManage,
    3: Menu()
      ..menuIcon = Icons.add
      ..menuTxt = "我的账号"
      ..menuId = 3
      ..menuRoute = Routes.accountOwner,
    4: Menu()
      ..menuIcon = Icons.edit_note
      ..menuTxt = "内容管理"
      ..menuId = 4
      ..menuRoute = "",
    5: Menu()
      ..menuIcon = Icons.add
      ..menuTxt = "笔记管理"
      ..menuId = 5
      ..menuRoute = Routes.manageNote,
    6: Menu()
      ..menuIcon = Icons.add
      ..menuTxt = "话题管理"
      ..menuId = 6
      ..menuRoute = Routes.manageTopic,
    7: Menu()
      ..menuIcon = Icons.add
      ..menuTxt = "表情管理"
      ..menuId = 7
      ..menuRoute = Routes.manageEmoji,
    8: Menu()
      ..menuIcon = Icons.add
      ..menuTxt = "分类管理"
      ..menuId = 8
      ..menuRoute = Routes.manageClassify,
    9: Menu()
      ..menuIcon = Icons.add
      ..menuTxt = "笔记审核"
      ..menuId = 9
      ..menuRoute = Routes.manageVerify,
    10: Menu()
      ..menuIcon = Icons.search
      ..menuTxt = "搜索管理"
      ..menuId = 10
      ..menuRoute = "",
    11: Menu()
      ..menuIcon = Icons.add
      ..menuTxt = "热搜管理"
      ..menuId = 11
      ..menuRoute = Routes.searchManage,
    12: Menu()
      ..menuIcon = Icons.upload
      ..menuTxt = "上传发布"
      ..menuId = 12
      ..menuRoute = "",
    13: Menu()
      ..menuIcon = Icons.add
      ..menuTxt = "推荐笔记"
      ..menuId = 13
      ..menuRoute = Routes.pubRecommend,
    14: Menu()
      ..menuIcon = Icons.add
      ..menuTxt = "创意中心"
      ..menuId = 14
      ..menuRoute = Routes.pubCreative,
    15: Menu()
      ..menuIcon = Icons.report
      ..menuTxt = "举报受理"
      ..menuId = 15
      ..menuRoute = "",
    16: Menu()
      ..menuIcon = Icons.add
      ..menuTxt = "用户举报"
      ..menuId = 16
      ..menuRoute = Routes.reportUser,
    17: Menu()
      ..menuIcon = Icons.add
      ..menuTxt = "笔记举报"
      ..menuId = 17
      ..menuRoute = Routes.reportNote,
  };

  List<Menu> menuList = [
    Menu()
      ..menuIcon = Icons.account_circle
      ..menuTxt = "账号管理"
      ..menuId = 1
      ..menuRoute = ""
      ..children = [
        Menu()
          ..menuTxt = "账号管理"
          ..menuId = 2
          ..menuRoute = Routes.accountManage,
        Menu()
          ..menuTxt = "我的账号"
          ..menuId = 3
          ..menuRoute = Routes.accountOwner,
      ],
  ];

  bool isLoadingMenu = false;

  // @override
  // void onReady() {
  //   super.onReady();
  //   requestMenuList();
  // }

  Future<void> requestMenuList() async {
    await get(HttpConstants.menuList, success: onMenuListSuccess);
  }

  void onMenuListSuccess(data) {
    menuList.clear();

    List tempList = data ?? [];
    for (var temp in tempList) {
      BeanMenu bean = BeanMenu.fromJson(temp);
      if (routeMap[bean.resourceId] == null) continue;

      if (bean.parentId == 0) {
        menuList.add(routeMap[bean.resourceId]!);
      } else {
        if (routeMap[bean.parentId] == null) continue;
        Menu? parent =
            menuList.firstWhereOrNull((x) => x.menuId == bean.parentId);
        if (parent == null) {
          parent = routeMap[bean.parentId]!;
          menuList.add(parent);
        }
        parent.children.add(routeMap[bean.resourceId]!);
      }
    }

    isLoadingMenu = false;
    update(["home-menu", "home-page"]);
  }
}

class Menu {
  int menuId = 0;

  String menuRoute = "";

  String menuTxt = "";

  IconData menuIcon = Icons.account_circle;

  List<Menu> children = [];
}
