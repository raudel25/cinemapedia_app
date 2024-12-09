import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/providers/movies/movie_repository_provider.dart';
import 'package:cinemapedia_app/config/utils/data_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final load = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MoviesNotifier(load: load);
});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 1;
  bool isLoading = false;
  final Future<DataResponse<List<Movie>>> Function({int page}) load;

  MoviesNotifier({required this.load}) : super(<Movie>[]);

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;

    currentPage++;
    final response = await load(page: currentPage);

    if (response.success) {
      state = [...state, ...response.data!];
    } else {
      currentPage--;
    }

    isLoading = false;
  }
}
