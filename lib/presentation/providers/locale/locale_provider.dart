import 'package:cinemapedia_app/config/language/app_language.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod/riverpod.dart';

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(globalLanguage.locale);

  void updateLocale(Locale locale) async {
    state = locale;
    globalLanguage.locale = locale;
    await globalLanguage.save();
  }
}
