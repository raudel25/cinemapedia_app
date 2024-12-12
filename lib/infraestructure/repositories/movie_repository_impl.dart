import 'package:cinemapedia_app/domain/data/movie_data.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/domain/repositories/movie_repository.dart';
import 'package:cinemapedia_app/config/utils/data_response.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieData data;

  MovieRepositoryImpl({required this.data});

  @override
  Future<DataResponse<List<Movie>>> getNowPlaying(
          {int page = 1, String? language}) =>
      data.getNowPlaying(page: page, language: language);

  @override
  Future<DataResponse<List<Movie>>> getUpcoming(
          {int page = 1, String? language}) =>
      data.getUpcoming(page: page, language: language);

  @override
  Future<DataResponse<List<Movie>>> getPopular(
          {int page = 1, String? language}) =>
      data.getPopular(page: page, language: language);

  @override
  Future<DataResponse<List<Movie>>> getTopRated(
          {int page = 1, String? language}) =>
      data.getTopRated(page: page, language: language);

  @override
  Future<DataResponse<Movie>> getMovieById(String id, {String? language}) =>
      data.getMovieById(id, language: language);

  @override
  Future<DataResponse<List<Movie>>> searchMovie(String query,
          {String? language}) =>
      data.searchMovie(query, language: language);
}
