import 'package:cinemapedia_app/config/languages/languages.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod/riverpod.dart';

final localeProvider = StateProvider<Locale>((ref) {
  final systemLocale = Languages.startLocale;
  return Locale(systemLocale.languageCode, systemLocale.countryCode);
});
