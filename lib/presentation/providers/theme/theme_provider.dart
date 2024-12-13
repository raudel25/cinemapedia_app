import 'package:cinemapedia_app/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, AppTheme>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<AppTheme> {
  ThemeNotifier() : super(globalTheme);

  void updateIsDarkMode(bool isDarkMode) async {
    state = state.copyWith(isDarkMode: isDarkMode);
    globalTheme.isDarkMode = isDarkMode;
    await globalTheme.save();
  }
}
