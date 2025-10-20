import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const Color(0xFF575CFF),
    scaffoldBackgroundColor: const Color(0xFFF6F6F6),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      foregroundColor: Colors.black87,
      backgroundColor: Colors.white,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}
