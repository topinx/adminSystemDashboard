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
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    constraints: const BoxConstraints(minHeight: 45),
    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
    hintStyle: const TextStyle(color: Color(0xFFEBEBEB)),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: Color(0xFFEBEBEB), width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: Color(0xFFEBEBEB), width: 1),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: Color(0xFFEBEBEB), width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: Color(0xFF3871BB), width: 1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: Colors.red, width: 1),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
  ),
);
