import 'package:cinemapedia_app/config/utils/data_response.dart';
import 'package:cinemapedia_app/config/utils/snack_bar.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/providers/locale/locale_provider.dart';
import 'package:cinemapedia_app/presentation/providers/movies/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return MovieMapNotifier(getMovie: movieRepository.getMovieById, ref: ref);
});

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final Future<DataResponse<Movie>> Function(String id, {String? language})
      getMovie;
  final Ref ref;

  final Map<(String, String), Movie> _localeState = {};

  MovieMapNotifier({
    required this.getMovie,
    required this.ref,
  }) : super({});

  Future<void> loadMovie(String movieId) async {
    final locale = ref.read(localeProvider).toString();

    if (_localeState[(movieId, locale)] != null) {
      state = {...state, movieId: _localeState[(movieId, locale)]!};
      return;
    }

    final response = await getMovie(movieId, language: locale);
    if (!response.success) {
      globalSnackBar.showSnackBarResponse(response);
      return;
    }

    state = {...state, movieId: response.data!};
    _localeState[(movieId, locale)] = response.data!;
  }
}
