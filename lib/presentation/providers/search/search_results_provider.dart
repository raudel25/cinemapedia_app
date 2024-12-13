import 'package:cinemapedia_app/config/utils/data_response.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchResultMoviesProvider =
    StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
  final locale = ref.read(localeProvider.notifier).state;

  final movieRepository = ref.read(movieRepositoryProvider);

  return SearchedMoviesNotifier(
      searchMovies: (query) =>
          movieRepository.searchMovie(query, language: locale.toString()),
      ref: ref);
});

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  final Future<DataResponse<List<Movie>>> Function(String query) searchMovies;
  final Ref ref;

  SearchedMoviesNotifier({
    required this.searchMovies,
    required this.ref,
  }) : super([]);

  Future<List<Movie>> loadMovies(String query) async {
    final response = await searchMovies(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);

    state = response.data ?? [];
    return response.data ?? [];
  }
}
