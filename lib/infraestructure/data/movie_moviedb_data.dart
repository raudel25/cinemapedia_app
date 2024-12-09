import 'package:cinemapedia_app/config/constants/enviroment.dart';
import 'package:cinemapedia_app/infraestructure/mappers/movie_mapper.dart';
import 'package:cinemapedia_app/infraestructure/models/movie_moviedb_response.dart';
import 'package:dio/dio.dart';

import 'package:cinemapedia_app/domain/data/movie_data.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/config/utils/data_response.dart';

class MovieMovieDbData extends MovieData {
  final dio = Dio(BaseOptions(
      baseUrl: Environment.theMovieDbBaseUrl,
      queryParameters: {'api_key': Environment.theMovieDbKey}));

  @override
  Future<DataResponse<List<Movie>>> getNowPlaying(
      {int page = 1, String? language}) async {
    Map<String, dynamic> query = {'page': page};

    if (language != null) query['language'] = language.replaceAll(r'_', '-');

    try {
      final response =
          await dio.get('/movie/now_playing', queryParameters: query);

      final movies = MovieMovieDbResponse.fromJson(response.data)
          .results
          .where((e) => e.posterPath != '-')
          .map((e) => MovieMapper.movieDbToEntity(e))
          .toList();

      return DataResponse(success: true, data: movies);
    } catch (_) {
      return DataResponse(success: false);
    }
  }
}
