import 'package:flutter/material.dart';
import 'package:top_back/app/widgets/responsive_widget.dart';
import 'package:top_back/contants/app_storage.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  void onTapSearch() {}

  void onTapNotify() {}

  void onTapLogin() {}

  Widget buildAppBarContent(BuildContext context) {
    return AppStorage().beanLogin.token.isEmpty
        ? ElevatedButton(onPressed: onTapLogin, child: const Text("登录"))
        : Row(children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Theme.of(context).dialogBackgroundColor,
            ),
            const SizedBox(width: 15),
            SizedBox(
              width: 100,
              child: Text(AppStorage().beanLogin.nickname,
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
          ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: Row(children: [
        const DrawerMenuButton(),
        const Spacer(),
        IconButton(onPressed: onTapSearch, icon: const Icon(Icons.search)),
        const SizedBox(width: 5),
        IconButton(
            onPressed: onTapNotify, icon: const Icon(Icons.notifications_none)),
        const SizedBox(width: 5),
        buildAppBarContent(context),
      ]),
    );
  }
}

class DrawerMenuButton extends StatelessWidget {
  const DrawerMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (type, constraints) {
        return Visibility(
          visible: type != ResponsiveType.desktop,
          child: IconButton(
            onPressed: Scaffold.of(context).openDrawer,
            icon: const Icon(Icons.menu),
          ),
        );
      },
    );
  }
}
