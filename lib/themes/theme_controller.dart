import 'package:flutter/material.dart';
import '../core/storage/local_storage.dart';
import '../core/utils/app_constants.dart';

class ThemeController extends ChangeNotifier {
  ThemeController({
    required LocalStorage storage,
  }) : _storage = storage {
    _loadThemeMode();
  }

  final LocalStorage _storage;

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  Future<void> toggleTheme() async {
    _themeMode =
        _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await _storage.setString(
      AppConstants.themeModeStorageKey,
      _themeMode.name,
    );
    notifyListeners();
  }

  void _loadThemeMode() {
    final storedValue = _storage.getString(AppConstants.themeModeStorageKey);
    _themeMode = switch (storedValue) {
      'dark' => ThemeMode.dark,
      'light' => ThemeMode.light,
      _ => ThemeMode.system,
    };
  }
}
