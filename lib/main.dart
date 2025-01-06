import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:top_back/app/app_delegate.dart';
import 'package:top_back/contants/app_storage.dart';
import 'package:top_back/contants/theme.dart';
import 'package:top_back/app/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppStorage().init().then((_) => runApp(const App()));
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
      scrollBehavior: const ScrollBehavior()
          .copyWith(dragDevices: PointerDeviceKind.values.toSet()),
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      themeMode: ThemeMode.light,
      getPages: AppPages.routes,
      routerDelegate: AppDelegate.delegate,
      onInit: () {
        final delegate = Get.rootController.rootDelegate;
        delegate.navigatorObservers?.add(GetObserver(null, Get.routing));
      },
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('zh', 'CN'),
      supportedLocales: const [Locale('en', 'US'), Locale('zh', 'CN')],
    );
  }
}
