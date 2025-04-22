

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _storage = GetStorage();
  final _key = 'isDarkMode';

  
  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  
  bool get isDarkMode => themeMode.value == ThemeMode.dark;

  @override
  void onInit() {
    super.onInit();
    loadThemeMode();
  }

  
  void loadThemeMode() {
    final savedMode = _storage.read<String>(_key);
    if (savedMode != null) {
      themeMode.value = getThemeModeFromString(savedMode);
    } else {
      
      themeMode.value = ThemeMode.system;
    }
  }

  
  void toggleTheme() {
    themeMode.value = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    _saveThemeMode();
  }

  
  void changeThemeMode(ThemeMode mode) {
    themeMode.value = mode;
    _saveThemeMode();
  }

  
  void _saveThemeMode() {
    _storage.write(_key, themeMode.value.toString().split('.').last);
  }

  
  ThemeMode getThemeModeFromString(String themeString) {
    switch (themeString) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}