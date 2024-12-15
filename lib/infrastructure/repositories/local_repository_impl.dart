import 'package:cinemapedia_app/domain/data/local_data.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/domain/repositories/local_repository.dart';

class LocalRepositoryImpl extends LocalRepository {
  final LocalData data;

  LocalRepositoryImpl({required this.data});

  @override
  Future<bool> isMovieFavorite(int movieId) => data.isMovieFavorite(movieId);

  @override
  Future<List<Movie>> loadMovies({int page = 1, int size = 10}) =>
      data.loadMovies(page: page, size: size);

  @override
  Future<void> toggleFavorite(Movie movie) => data.toggleFavorite(movie);
}
