import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/domain/repositories/local_repository.dart';
import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isFavoriteMovieProvider = FutureProvider.family((ref, int movieId) {
  return ref.watch(localRepositoryProvider).isMovieFavorite(movieId);
});

final favoriteMoviesProvider =
    StateNotifierProvider<FavoriteMoviesNotifier, Map<int, Movie>>((ref) {
  final localRepository = ref.watch(localRepositoryProvider);
  return FavoriteMoviesNotifier(localRepository: localRepository);
});

class FavoriteMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int currentPage = 0;
  bool isLoading = false;
  final LocalRepository localRepository;

  FavoriteMoviesNotifier({required this.localRepository}) : super({});

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;

    currentPage++;
    final movies =
        await localRepository.loadMovies(page: currentPage, size: 20);

    final tempMoviesMap = <int, Movie>{};
    for (final movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }

    state = {...state, ...tempMoviesMap};

    isLoading = false;
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
