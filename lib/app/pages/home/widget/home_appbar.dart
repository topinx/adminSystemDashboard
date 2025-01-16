import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/pages/home/controller/home_controller.dart';
import 'package:top_back/app/widgets/responsive_widget.dart';
import 'package:top_back/contants/app_storage.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

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
      child: GetBuilder<HomeController>(
          id: "home-pub",
          builder: (ctr) {
            return Row(children: [
              const DrawerMenuButton(),
              if (ctr.isNoteUpload) ...[
                const SizedBox(width: 5),
                const SizedBox(
                  width: 10,
                  height: 10,
                  child: CircularProgressIndicator(color: Colors.blue),
                ),
                const SizedBox(width: 10),
                Text(ctr.isPub ? "笔记发布中···" : "笔记修改中···",
                    style: const TextStyle(color: Colors.blue)),
              ],
              const Spacer(),
              IconButton(
                  onPressed: onTapNotify,
                  icon: const Icon(Icons.notifications_none)),
              const SizedBox(width: 5),
              buildAppBarContent(context),
            ]);
          }),
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
