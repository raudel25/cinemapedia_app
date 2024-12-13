import 'package:cinemapedia_app/config/language/app_language.dart';
import 'package:cinemapedia_app/config/router/app_router.dart';
import 'package:cinemapedia_app/config/theme/app_theme.dart';
import 'package:cinemapedia_app/config/utils/snack_bar.dart';
import 'package:cinemapedia_app/presentation/providers/theme/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future main() async {
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  await globalLanguage.load();
  await globalTheme.load();
  await EasyLocalization.ensureInitialized();

  runApp(ProviderScope(
      child: EasyLocalization(
          supportedLocales: AppLanguage.supportedLocales,
          fallbackLocale: AppLanguage.defaultLocale,
          startLocale: globalLanguage.locale,
          path: 'assets/translations',
          child: const MyApp())));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, ref) {
    return MaterialApp.router(
      scaffoldMessengerKey: globalSnackBar.messengerKey,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      routerConfig: appRouter,
      theme: ref.watch(themeProvider).theme,
    );
  }
}
