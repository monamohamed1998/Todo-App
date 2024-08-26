import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;
  String language = 'en';

  SettingsProvider() {
    _loadSettings();
  }

  bool get isdark => themeMode == ThemeMode.dark;

  String get bgImg =>
      isdark ? "assets/images/dark_bg.png" : "assets/images/bg3.png";

  void changeThemeMode(ThemeMode selectedThemeMode) {
    themeMode = selectedThemeMode;
    _saveThemeMode(selectedThemeMode);
    notifyListeners();
  }

  void changeLanguage(String selectedLanguage) {
    language = selectedLanguage;
    _saveLanguage(selectedLanguage);
    notifyListeners();
  }

  Future<void> _saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'themeMode', mode == ThemeMode.dark ? 'dark' : 'light');
  }

  Future<void> _saveLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', lang);
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    // Load theme mode
    String? themeModeString = prefs.getString('themeMode');
    themeMode = themeModeString == 'dark' ? ThemeMode.dark : ThemeMode.light;

    // Load language
    language = prefs.getString('language') ?? 'en';

    notifyListeners();
  }
}
