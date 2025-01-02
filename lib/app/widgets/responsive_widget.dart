import 'package:flutter/material.dart';

/// 手机到平板的过度边界
const mobileToTable = 750;

/// 平板到桌面的过度边界
const tableToDesktop = 1200;

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
        if (screenW > mobileToTable && screenW <= tableToDesktop) {
          type = ResponsiveType.table;
        } else if (screenW > tableToDesktop) {
          type = ResponsiveType.desktop;
        }
        return builder(type, constraints);
      },
    );
  }
}
