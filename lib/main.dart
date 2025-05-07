import 'package:top_back/router/router.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';

import 'constants/app_storage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Storage().init().then((_) => runApp(const ProviderScope(child: App())));
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp.router(
        scrollBehavior: const ScrollBehavior().copyWith(
          scrollbars: false,
          dragDevices: PointerDeviceKind.values.toSet(),
        ),
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        theme: FlexThemeData.light(scheme: FlexScheme.indigoM3).copyWith(
          progressIndicatorTheme:
              ProgressIndicatorThemeData(color: Colors.transparent),
        ),
        routerConfig: router,
      ),
    );
  }
}
