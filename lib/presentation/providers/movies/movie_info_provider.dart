import 'package:cinemapedia_app/config/utils/data_response.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/providers/locale/locale_provider.dart';
import 'package:cinemapedia_app/presentation/providers/movies/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final locale = ref.read(localeProvider.notifier).state;

  final movieRepository = ref.watch(movieRepositoryProvider);
  return MovieMapNotifier(
      getMovie: (String id) =>
          movieRepository.getMovieById(id, language: locale.toString()));
});

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final Future<DataResponse<Movie>> Function(String id) getMovie;

  MovieMapNotifier({
    required this.getMovie,
  }) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;
    final response = await getMovie(movieId);
    if (!response.success) return;

    state = {...state, movieId: response.data!};
  }
}
