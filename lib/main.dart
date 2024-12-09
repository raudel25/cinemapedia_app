import 'dart:ui';

import 'package:cinemapedia_app/config/router/app_router.dart';
import 'package:cinemapedia_app/config/theme/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

(List<Locale>, Locale) getLocaleConf() {
  final systemLocale = PlatformDispatcher.instance.locale;
  const supportedLocales = [Locale('en', 'US'), Locale('es', 'ES')];
  return (
    supportedLocales,
    supportedLocales
            .where((e) =>
                e.languageCode == systemLocale.languageCode &&
                e.countryCode == systemLocale.countryCode)
            .firstOrNull ??
        supportedLocales
            .where((e) => e.languageCode == systemLocale.languageCode)
            .firstOrNull ??
        const Locale('en', 'US')
  );
}

Future main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  final (supportedLocales, systemLocale) = getLocaleConf();

  runApp(ProviderScope(
      child: EasyLocalization(
    supportedLocales: supportedLocales,
    fallbackLocale: const Locale('en', 'US'),
    startLocale: systemLocale,
    path: 'assets/translations',
    child: const MyApp(),
  )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      routerConfig: appRouter,
      theme: AppTheme().theme,
    );
  }
}
