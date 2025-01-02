import 'package:flutter/material.dart';

ThemeData themeData = ThemeData.light().copyWith(
  primaryColor: const Color(0xFF3871BB),
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  secondaryHeaderColor: const Color(0xFFF5F5F5),
  expansionTileTheme: const ExpansionTileThemeData(
    textColor: Color(0xFFFFFFFF),
    collapsedTextColor: Color(0xFF979797),
    iconColor: Color(0xFFFFFFFF),
    collapsedIconColor: Color(0xFF979797),
    shape: RoundedRectangleBorder(side: BorderSide.none),
    collapsedShape: RoundedRectangleBorder(side: BorderSide.none),
  ),
  listTileTheme: const ListTileThemeData(
    textColor: Color(0xFFFFFFFF),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFFFFFFF),
  ),
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
    ),
  ),
);
