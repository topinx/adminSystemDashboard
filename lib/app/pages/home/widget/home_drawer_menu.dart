import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/app_delegate.dart';
import 'package:top_back/app/widgets/responsive_widget.dart';

import '../controller/home_controller.dart';
import 'home_drawer_logo.dart';

class HomeDrawerMenu extends StatelessWidget {
  const HomeDrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (type, constraints) {
        switch (type) {
          case ResponsiveType.mobile:
          case ResponsiveType.table:
            return const SizedBox();
          case ResponsiveType.desktop:
            return const HomeDrawer();
        }
      },
    );
  }
}

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  void onTapMenu(String route) {
    AppDelegate.delegate.toNamed(route);
  }

  Widget buildExpansionItem(Menu menu) {
    List<Widget> children = List.generate(
      menu.children.length,
      (i) => ListTile(
        leading: const SizedBox(),
        onTap: () => onTapMenu(menu.children[i].menuRoute),
        title: Text(menu.children[i].menuTxt),
      ),
    );

    return ExpansionTile(
      leading: Icon(menu.menuIcon),
      title: Text(menu.menuTxt),
      initiallyExpanded: false,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      color: const Color(0xFF252A34),
      child: Column(children: [
        const HomeDrawerLogo(),
        Expanded(
          child: GetBuilder<HomeController>(builder: (ctr) {
            return ctr.isLoadingMenu
                ? const Center(child: CupertinoActivityIndicator(radius: 6))
                : ListView.builder(
                    itemCount: ctr.menuList.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (_, i) => buildExpansionItem(ctr.menuList[i]),
                  );
          }),
        ),
      ]),
    );
  }
}
