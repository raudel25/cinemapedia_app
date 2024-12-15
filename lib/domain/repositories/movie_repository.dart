import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/config/utils/data_response.dart';

abstract class MovieRepository {
  Future<DataResponse<List<Movie>>> getNowPlaying(
      {int page = 1, String language});

  Future<DataResponse<List<Movie>>> getPopular(
      {int page = 1, String? language});

  Future<DataResponse<List<Movie>>> getUpcoming(
      {int page = 1, String? language});

  Future<DataResponse<List<Movie>>> getTopRated(
      {int page = 1, String? language});

  Future<DataResponse<Movie>> getMovieById(String id, {String? language});

  Future<DataResponse<List<Movie>>> searchMovie(String query,
      {String? language});

  Future<DataResponse<List<Movie>>> getMoviesByCategory(int categoryId,
      {int page = 1, String? language});
}
