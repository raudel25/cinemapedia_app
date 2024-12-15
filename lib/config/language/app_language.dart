import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage {
  static const supportedLocales = [Locale('en', 'US'), Locale('es', 'ES')];
  static const defaultLocale = Locale('en', 'US');

  Locale locale = defaultLocale;

  static Locale _systemLocale() {
    final systemLocale = PlatformDispatcher.instance.locale;
    return supportedLocales
            .where((e) =>
                e.languageCode == systemLocale.languageCode &&
                e.countryCode == systemLocale.countryCode)
            .firstOrNull ??
        supportedLocales
            .where((e) => e.languageCode == systemLocale.languageCode)
            .firstOrNull ??
        defaultLocale;
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final locale = prefs.getString('locale');

    this.locale = locale == null
        ? _systemLocale()
        : Locale(locale.split('_')[0], locale.split('_')[1]);
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale.toString());
  }
}

final globalLanguage = AppLanguage();
