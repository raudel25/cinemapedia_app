import 'package:cinemapedia_app/config/language/app_language.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/deleagtes/search_movie_delegate.dart';
import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:cinemapedia_app/presentation/providers/theme/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    final isDarkMode = ref.watch(themeProvider).isDarkMode;
    final locale = ref.watch(localeProvider);

    return SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Icon(
                  Icons.movie_outlined,
                  color: colors.primary,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Cinemapedia',
                  style: titleStyle,
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      final newLocale = AppLanguage.supportedLocales
                          .firstWhere((e) => e != locale);
                      ref.read(localeProvider.notifier).updateLocale(newLocale);
                      context.setLocale(newLocale);
                    },
                    icon: Text(locale.countryCode!)),
                IconButton(
                    onPressed: () => ref
                        .read(themeProvider.notifier)
                        .updateIsDarkMode(!isDarkMode),
                    icon: !isDarkMode
                        ? const Icon(Icons.dark_mode_rounded)
                        : const Icon(Icons.light_mode_rounded)),
                IconButton(
                    onPressed: () => showSearch<Movie?>(
                            query: ref.watch(searchQueryProvider),
                            context: context,
                            delegate: SearchMovieDelegate(
                                lastQuery: ref.watch(searchQueryProvider),
                                initialMovies:
                                    ref.watch(searchResultMoviesProvider),
                                searchMovie: (query) => ref
                                    .read(searchResultMoviesProvider.notifier)
                                    .loadMovies(query))).then((movie) {
                          if (movie != null) {
                            context.push('/home/0/movie/${movie.id}');
                          }
                        }),
                    icon: const Icon(Icons.search))
              ],
            ),
          ),
        ));
  }
}
