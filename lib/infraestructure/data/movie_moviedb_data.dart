import 'package:cinemapedia_app/config/constants/enviroment.dart';
import 'package:cinemapedia_app/infraestructure/mappers/movie_mapper.dart';
import 'package:cinemapedia_app/infraestructure/models/movie_moviedb_details.dart';
import 'package:cinemapedia_app/infraestructure/models/movie_moviedb_response.dart';
import 'package:dio/dio.dart';

import 'package:cinemapedia_app/domain/data/movie_data.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/config/utils/data_response.dart';

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

      final movieDetails = MovieMovieDbDetails.fromJson(response.data);
      final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);
      return DataResponse(success: true, data: movie);
    } catch (_) {
      return DataResponse(success: false);
    }
  }
}
