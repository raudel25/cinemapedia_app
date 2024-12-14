import 'package:cinemapedia_app/domain/entities/movie.dart';

abstract class LocalRepository {
  Future<void> toggleFavorite(Movie movie);
  Future<bool> isMovieFavorite(int movieId);
  Future<List<Movie>> loadMovies({int page = 1, int size = 10});
}
