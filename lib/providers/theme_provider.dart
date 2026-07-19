import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';

/// Manages dark/light theme state.
class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = true;

  bool get isDarkMode => _isDarkMode;
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  ThemeProvider() {
    _isDarkMode = LocalStorageService.isDarkMode;
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    LocalStorageService.setDarkMode(_isDarkMode);
    notifyListeners();
  }

  void setDarkMode(bool value) {
    _isDarkMode = value;
    LocalStorageService.setDarkMode(value);
    notifyListeners();
  }
}
