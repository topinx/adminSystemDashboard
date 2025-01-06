import 'package:flutter/material.dart';

/// 手机到平板的过度边界
const double kMobileToTable = 640;

/// 平板到桌面的过度边界
const double kTableToDesktop = 1200;

enum ResponsiveType { mobile, table, desktop }

typedef ResponsiveInfo = Widget Function(ResponsiveType, BoxConstraints);

class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget({super.key, required this.builder});

  final ResponsiveInfo builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        MediaQueryData media = MediaQuery.of(context);

        double screenW = media.size.width;
        ResponsiveType type = ResponsiveType.mobile;
        if (screenW > kMobileToTable && screenW <= kTableToDesktop) {
          type = ResponsiveType.table;
        } else if (screenW > kTableToDesktop) {
          type = ResponsiveType.desktop;
        }
        return builder(type, constraints);
      },
    );
  }
}
