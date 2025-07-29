import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _is_dark = false;
  bool get isDark => _is_dark;
  ThemeMode get currenttheme => _is_dark ? ThemeMode.dark : ThemeMode.light;

  void load_prefrences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _is_dark = prefs.getBool("is_dark") ?? false;
    notifyListeners();
  }

  void toggleTheme() async {
    _is_dark = !_is_dark;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("is_dark", _is_dark);
    notifyListeners();
  }
}
