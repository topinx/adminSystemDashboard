import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/pages.dart';

import 'controller/home_controller.dart';
import 'widget/home_appbar.dart';
import 'widget/home_drawer_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController ctr = Get.find<HomeController>();

  Iterable<GetPage> onRouterFilterPages(Iterable<GetPage> pageList) {
    var ret = pageList.toList();
    if (ret.isEmpty && ModalRoute.of(context)!.isCurrent) {
      ret.add(context.delegate.matchRoute(Routes.accountManage).route!);
    }
    final navigator =
        Get.nestedKey(Routes.home)?.navigatorKey.currentState?.widget;

    if (navigator != null) {
      if (ret.isEmpty) return navigator.pages as List<GetPage>;

      final splitLen = ret[0].name.split('/').length;

      for (var page in navigator.pages as List<GetPage>) {
        if (page.maintainState &&
            page.name.split('/').length == splitLen &&
            !ret.contains(page)) {
          ret.insert(0, page);
        }
      }
    }
    ret = ret.where((e) => e.participatesInRootNavigator != true).toList();
    return ret;
  }

  Widget buildMenuPage() {
    return GetBuilder<HomeController>(builder: (ctr) {
      return Expanded(
        child: ctr.isLoadingMenu
            ? const Center(child: CupertinoActivityIndicator(radius: 6))
            : GetRouterOutlet(
                initialRoute: Routes.accountManage,
                anchorRoute: Routes.home,
                filterPages: onRouterFilterPages,
              ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      route: Routes.home,
      builder: (context) {
        return Scaffold(
            backgroundColor: Theme.of(context).secondaryHeaderColor,
            drawer: const HomeDrawer(),
            body: Row(children: [
              const HomeDrawerMenu(),
              Expanded(
                child: Column(children: [const HomeAppBar(), buildMenuPage()]),
              ),
            ]));
      },
    );
  }
}
