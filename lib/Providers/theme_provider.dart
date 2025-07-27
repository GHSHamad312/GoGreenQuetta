import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _is_dark = false;
  bool get isDark => _is_dark;
  ThemeMode get currenttheme => _is_dark ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _is_dark = !_is_dark;
    notifyListeners();
  }
}
