import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/domain/repositories/local_repository.dart';
import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isFavoriteMovieProvider = FutureProvider.family((ref, int movieId) {
  return ref.watch(localRepositoryProvider).isMovieFavorite(movieId);
});

final movieFavoritesProvider =
    StateNotifierProvider<MovieFavoritesNotifier, Map<int, Movie>>((ref) {
  final localRepository = ref.watch(localRepositoryProvider);
  return MovieFavoritesNotifier(localRepository: localRepository);
});

class MovieFavoritesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  final LocalRepository localRepository;

  MovieFavoritesNotifier({required this.localRepository}) : super({});

  Future<List<Movie>> loadNextPage() async {
    page++;
    final movies = await localRepository.loadMovies(page: page, size: 20);

    final tempMoviesMap = <int, Movie>{};
    for (final movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }

    state = {...state, ...tempMoviesMap};

    return movies;
  }

  Future<void> toggleFavorite(Movie movie) async {
    await localRepository.toggleFavorite(movie);
    final bool isMovieInFavorites = state[movie.id] != null;

    if (isMovieInFavorites) {
      state.remove(movie.id);
      state = {...state};
    } else {
      state = {...state, movie.id: movie};
    }
  }
}
