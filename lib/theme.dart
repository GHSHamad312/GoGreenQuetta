import 'package:flutter/material.dart';

class AppTheme {
  // Light Theme Colors
  static const Color primaryLight = Color(0xFF388E3C);
  static const Color secondaryLight = Color(0xFF66BB6A);
  static const Color backgroundLight = Color(0xFFF5F7FA);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color accentLight = Color(0xFFE8F5E9);
  static const Color textLight = Color(0xFF1B1B1B);
  static const Color borderLight = Color(0xFFE0E0E0);
  static const Color errorLight = Color(0xFFD32F2F);

  // Dark Theme Colors (Low Eye Strain)
  static const Color primaryDark = Color(0xFF1DB954); // Vibrant green
  static const Color secondaryDark = Color(0xFF43A047);
  static const Color backgroundDark = Color.fromARGB(
    255,
    66,
    66,
    66,
  ); // Softer dark base
  static const Color cardDark = Color(0xFF2A2B2D);
  static const Color accentDark = Color(0xFF2C2C2C);
  static const Color textDark = Color(0xFFCCCCCC); // Muted off-white
  static const Color borderDark = Color(0xFF3A3A3A);
  static const Color errorDark = Color(0xFFEF5350);

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryLight,
    scaffoldBackgroundColor: backgroundLight,
    cardColor: cardLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryLight,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    colorScheme: ColorScheme.light(
      primary: primaryLight,
      secondary: secondaryLight,
      background: backgroundLight,
      surface: cardLight,
      error: errorLight,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: textLight,
      onSurface: textLight,
      onError: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16, color: textLight),
      bodyMedium: TextStyle(fontSize: 14, color: textLight),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textLight,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: cardLight,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: borderLight),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryLight, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      labelStyle: const TextStyle(color: textLight),
      hintStyle: TextStyle(color: textLight.withOpacity(0.6)),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: primaryLight,
      contentTextStyle: const TextStyle(color: Colors.white),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: secondaryLight,
      foregroundColor: Colors.white,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryDark,
    scaffoldBackgroundColor: backgroundDark,
    cardColor: cardDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: cardDark,
      foregroundColor: textDark,
      elevation: 0,
    ),
    colorScheme: ColorScheme.dark(
      primary: primaryDark,
      secondary: secondaryDark,
      background: backgroundDark,
      surface: cardDark,
      error: errorDark,
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onBackground: textDark,
      onSurface: textDark,
      onError: Colors.black,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(fontSize: 16, color: textDark),
      bodyMedium: TextStyle(fontSize: 14, color: textDark),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textDark,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF2E2F30),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: borderDark),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: secondaryDark, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      labelStyle: const TextStyle(color: textDark),
      hintStyle: TextStyle(color: textDark.withOpacity(0.6)),
    ),
    dividerColor: borderDark,
    shadowColor: Colors.transparent,
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    iconTheme: const IconThemeData(color: secondaryDark),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryDark,
      foregroundColor: Colors.black,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: const Color(0xFF2E2F31),
      contentTextStyle: const TextStyle(color: textDark),
      actionTextColor: secondaryDark,
    ),
  );
}
