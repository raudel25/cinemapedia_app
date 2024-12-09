import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class Languages {
  static const supportedLocales = [Locale('en', 'US'), Locale('es', 'ES')];
  static const defaultLocale = Locale('en', 'US');
  static Locale get startLocale {
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
}
