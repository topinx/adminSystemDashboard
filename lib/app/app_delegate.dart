import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages.dart';

class AppDelegate {
  static GetDelegate? _delegate;
  static GetDelegate get delegate => _delegate ?? _createDelegate();

  static GetDelegate _createDelegate() {
    _delegate = GetDelegate(
      pages: AppPages.routes,
      navigatorObservers: <NavigatorObserver>[],
      pickPagesForRootNavigator: _pickPagesForRootNavigator,
    );
    return _delegate!;
  }

  static Iterable<GetPage> _pickPagesForRootNavigator(
      RouteDecoder currentNavStack) {
    final actives = Get.rootController.rootDelegate.activePages;
    final pageList = <GetPage>[];
    for (var page in actives) {
      if (page != currentNavStack && page.route?.maintainState != true) {
        continue;
      }
      final q = page.currentTreeBranch.lastWhere(
          (e) => e.participatesInRootNavigator == true,
          orElse: () => page.route!);

      if (pageList.contains(q)) {
        pageList.remove(q);
      }
      pageList.add(q);
    }
    return pageList;
  }
}
