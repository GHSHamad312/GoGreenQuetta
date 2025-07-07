import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  final String _themeKey = 'isDarkMode';

  ThemeProvider() {
    _loadTheme();
  }

  bool get isDarkMode => _isDarkMode;

  ThemeData get themeData => _isDarkMode ? darkTheme : lightTheme;

  void toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, _isDarkMode);
    notifyListeners();
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(_themeKey) ?? false;
    notifyListeners();
  }

  static final lightTheme = ThemeData(
    primaryColor: Colors.green.shade600,
    scaffoldBackgroundColor: Colors.grey[100],
    cardColor: Colors.white,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black87),
      bodyMedium: TextStyle(color: Colors.black54),
      headlineMedium: TextStyle(
        color: const Color.fromARGB(221, 230, 12, 12),
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: IconThemeData(color: Colors.green.shade700),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.green.shade600,
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green.shade600,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.green.shade600,
      contentTextStyle: TextStyle(color: Colors.white),
    ),
  );

  static final darkTheme = ThemeData(
    primaryColor: Colors.green.shade800,
    scaffoldBackgroundColor: Colors.grey[900],
    cardColor: Colors.grey[800],
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.grey[400]),
      headlineMedium: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    iconTheme: IconThemeData(color: Colors.green.shade400),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.green.shade800,
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green.shade800,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.green.shade800,
      contentTextStyle: TextStyle(color: Colors.white),
    ),
  );
}
