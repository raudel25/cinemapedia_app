import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme {
  bool isDarkMode;
  static const colorScheme = Color(0xFF2862f5);

  AppTheme({this.isDarkMode = false});

  ThemeData get theme => ThemeData(
        useMaterial3: true,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        colorSchemeSeed: colorScheme,
      );

  AppTheme copyWith({bool isDarkMode = false}) =>
      AppTheme(isDarkMode: isDarkMode);

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = await prefs.getBool('isDarkMode');

    this.isDarkMode = isDarkMode ?? ThemeMode.system == ThemeMode.dark;
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }
}

final globalTheme = AppTheme();
