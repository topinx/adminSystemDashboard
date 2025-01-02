import 'package:get/get.dart';
import 'package:top_back/contants/app_storage.dart';

import 'pages.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  Future<RouteDecoder?> redirectDelegate(RouteDecoder route) async {
    if (AppStorage().token.isEmpty) {
      final newRoute = Routes.LOGIN_THEN(route.pageSettings!.name);
      return RouteDecoder.fromRoute(newRoute);
    }
    return await super.redirectDelegate(route);
  }
}
