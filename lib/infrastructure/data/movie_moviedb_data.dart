import 'package:cinemapedia_app/config/constants/environment.dart';
import 'package:cinemapedia_app/domain/entities/video.dart';
import 'package:cinemapedia_app/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia_app/infrastructure/mappers/video_mapper.dart';
import 'package:cinemapedia_app/infrastructure/models/movie_moviedb_details.dart';
import 'package:cinemapedia_app/infrastructure/models/movie_moviedb_response.dart';
import 'package:cinemapedia_app/infrastructure/models/video_moviedb.dart';
import 'package:dio/dio.dart';

import 'package:cinemapedia_app/domain/data/movie_data.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/config/utils/data_response.dart';
import 'package:easy_localization/easy_localization.dart';

class MovieMovieDbData extends MovieData {
  final dio = Dio(BaseOptions(
      baseUrl: Environment.theMovieDbBaseUrl,
      queryParameters: {'api_key': Environment.theMovieDbKey}));

  List<Movie> _parseJson(Map<String, dynamic> json) =>
      MovieMovieDbResponse.fromJson(json)
          .results
          .where((e) => e.posterPath != '-')
          .map((e) => MovieMapper.movieDbToEntity(e))
          .toList();

  @override
  Future<DataResponse<List<Movie>>> getNowPlaying(
      {int page = 1, String? language}) async {
    Map<String, dynamic> query = {'page': page};

    if (language != null) query['language'] = language.replaceAll(r'_', '-');

    try {
      final response =
          await dio.get('/movie/now_playing', queryParameters: query);

      return DataResponse(success: true, data: _parseJson(response.data));
    } catch (_) {
      return DataResponse(success: false);
    }
  }

  @override
  Future<DataResponse<List<Movie>>> getUpcoming(
      {int page = 1, String? language}) async {
    Map<String, dynamic> query = {'page': page};

    if (language != null) query['language'] = language.replaceAll(r'_', '-');

    try {
      final response = await dio.get('/movie/upcoming', queryParameters: query);

      return DataResponse(success: true, data: _parseJson(response.data));
    } catch (_) {
      return DataResponse(success: false);
    }
  }

  @override
  Future<DataResponse<List<Movie>>> getPopular(
      {int page = 1, String? language}) async {
    Map<String, dynamic> query = {'page': page};

    if (language != null) query['language'] = language.replaceAll(r'_', '-');

    try {
      final response = await dio.get('/movie/popular', queryParameters: query);

      return DataResponse(success: true, data: _parseJson(response.data));
    } catch (_) {
      return DataResponse(success: false);
    }
  }

  @override
  Future<DataResponse<List<Movie>>> getTopRated(
      {int page = 1, String? language}) async {
    Map<String, dynamic> query = {'page': page};

    if (language != null) query['language'] = language.replaceAll(r'_', '-');

    try {
      final response =
          await dio.get('/movie/top_rated', queryParameters: query);

      return DataResponse(success: true, data: _parseJson(response.data));
    } catch (_) {
      return DataResponse(success: false);
    }
  }

  @override
  Future<DataResponse<Movie>> getMovieById(String id,
      {String? language}) async {
    Map<String, dynamic> query = {};

    if (language != null) query['language'] = language.replaceAll(r'_', '-');
    try {
      final response = await dio.get('/movie/$id', queryParameters: query);

      if (response.statusCode == 404) {
        return DataResponse(success: false, message: 'notFoundMovie'.tr());
      }

      final movieDetails = MovieMovieDbDetails.fromJson(response.data);
      final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);
      return DataResponse(success: true, data: movie);
    } catch (_) {
      return DataResponse(success: false);
    }
  }

  @override
  Future<DataResponse<List<Movie>>> searchMovie(String query,
      {String? language}) async {
    Map<String, dynamic> queryApi = {'query': query};

    if (language != null) queryApi['language'] = language.replaceAll(r'_', '-');

    try {
      final response =
          await dio.get('/search/movie', queryParameters: queryApi);

      return DataResponse(success: true, data: _parseJson(response.data));
    } catch (_) {
      return DataResponse(success: false);
    }
  }

  @override
  Future<DataResponse<List<Movie>>> getMoviesByCategory(int categoryId,
      {int page = 1, String? language}) async {
    Map<String, dynamic> query = {'page': page, 'with_genres': categoryId};

    if (language != null) query['language'] = language.replaceAll(r'_', '-');

    try {
      final response = await dio.get('/discover/movie', queryParameters: query);

      return DataResponse(success: true, data: _parseJson(response.data));
    } catch (_) {
      return DataResponse(success: false);
    }
  }

  @override
  Future<DataResponse<List<Movie>>> getSimilarMovies(int movieId,
      {String? language}) async {
    Map<String, dynamic> queryApi = {};

    if (language != null) queryApi['language'] = language.replaceAll(r'_', '-');

    try {
      final response =
          await dio.get('/movie/$movieId/similar', queryParameters: queryApi);

      return DataResponse(success: true, data: _parseJson(response.data));
    } catch (_) {
      return DataResponse(success: false);
    }
  }

  @override
  Future<DataResponse<List<Video>>> getYouTubeVideosById(int movieId,
      {String? language}) async {
    Map<String, dynamic> queryApi = {};

    if (language != null) queryApi['language'] = language.replaceAll(r'_', '-');

    try {
      final response = await dio.get('/movie/$movieId/videos');

      return DataResponse(
          success: true,
          data: MovieDbVideosResponse.fromJson(response.data)
              .results
              .where((e) => e.site == 'YouTube')
              .map((e) => VideoMapper.movieDbVideoToEntity(e))
              .toList());
    } catch (_) {
      return DataResponse(success: false);
    }
  }
}
