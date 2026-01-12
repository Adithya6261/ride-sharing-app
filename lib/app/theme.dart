import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      // fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardColor: const Color(0xFF121212),
      colorScheme: const ColorScheme.dark(
        primary: Colors.white,
        secondary: Colors.greenAccent,
      ),
    );
  }
}
