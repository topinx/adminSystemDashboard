import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_back/app/app_delegate.dart';
import 'package:top_back/contants/theme.dart';
import 'package:top_back/app/pages.dart';

void main() async {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Top Backstage',
      theme: themeData,
      themeMode: ThemeMode.light,
      getPages: AppPages.routes,
      routerDelegate: AppDelegate.delegate,
      onInit: () {
        final delegate = Get.rootController.rootDelegate;
        delegate.navigatorObservers?.add(GetObserver(null, Get.routing));
      },
    );
  }
}
