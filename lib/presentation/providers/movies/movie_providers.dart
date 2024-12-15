import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/providers/locale/locale_provider.dart';
import 'package:cinemapedia_app/presentation/providers/movies/movie_repository_provider.dart';
import 'package:cinemapedia_app/config/utils/data_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final notifier = MoviesNotifier(
      ref: ref, load: ref.watch(movieRepositoryProvider).getNowPlaying);

  ref.listen(localeProvider, (previousLocale, newLocale) {
    notifier.refresh();
  });

  return notifier;
});

final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final notifier = MoviesNotifier(
      ref: ref, load: ref.watch(movieRepositoryProvider).getPopular);

  ref.listen(localeProvider, (previousLocale, newLocale) {
    notifier.refresh();
  });

  return notifier;
});

final upcomingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final notifier = MoviesNotifier(
      ref: ref, load: ref.watch(movieRepositoryProvider).getUpcoming);

  ref.listen(localeProvider, (previousLocale, newLocale) {
    notifier.refresh();
  });

  return notifier;
});

final topRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final notifier = MoviesNotifier(
      ref: ref, load: ref.watch(movieRepositoryProvider).getTopRated);

  ref.listen(localeProvider, (previousLocale, newLocale) {
    notifier.refresh();
  });

  return notifier;
});

final moviesByCategoryProvider =
    StateNotifierProvider.family((ref, int categoryId) {
  final notifier = MoviesNotifier(
      ref: ref,
      load: ({int page = 1, String? language}) => ref
          .watch(movieRepositoryProvider)
          .getMoviesByCategory(categoryId, page: page, language: language));

  return notifier;
});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;
  final Ref ref;
  final Future<DataResponse<List<Movie>>> Function({int page, String? language})
      load;

  MoviesNotifier({required this.load, required this.ref}) : super(<Movie>[]);

  void refresh() => loadNextPage(refresh: true);

  Future<void> loadNextPage({bool refresh = false}) async {
    if (isLoading) return;
    isLoading = true;

    if (refresh) currentPage = 0;

    currentPage++;
    final response = await load(
        page: currentPage, language: ref.read(localeProvider).toString());

    if (refresh) state = [];

    if (response.success) {
      state = [...state, ...response.data!];
    } else {
      currentPage--;
    }

    isLoading = false;
  }
}
