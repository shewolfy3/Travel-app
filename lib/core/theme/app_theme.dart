import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF007BFF);
  static const Color secondary = Color(0xFF00C896);
  static const Color background = Color(0xFFF5F7FA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color dark = Color(0xFF1A1A2E);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color lightGrey = Color(0xFFEEEEEE);
  static const Color error = Color(0xFFE53935);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: background,
    fontFamily: 'Inter',
    colorScheme: const ColorScheme.light(
      primary: primary,
      secondary: secondary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: white,
      elevation: 0,
      iconTheme: IconThemeData(color: dark),
      titleTextStyle: TextStyle(
        color: dark,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        minimumSize: const Size(double.infinity, 52),
      ),
    ),
  );
}