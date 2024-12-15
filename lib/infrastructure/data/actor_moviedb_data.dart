import 'package:cinemapedia_app/config/constants/environment.dart';
import 'package:cinemapedia_app/config/utils/data_response.dart';
import 'package:cinemapedia_app/domain/data/actor_data.dart';
import 'package:cinemapedia_app/domain/entities/actor.dart';
import 'package:cinemapedia_app/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia_app/infrastructure/models/credits_response.dart';
import 'package:dio/dio.dart';

class ActorMovieDbData extends ActorData {
  final dio = Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
    'api_key': Environment.theMovieDbKey,
  }));

  @override
  Future<DataResponse<List<Actor>>> getActorsByMovie(String movieId,
      {String? language}) async {
    Map<String, dynamic> query = {};

    if (language != null) query['language'] = language.replaceAll(r'_', '-');

    try {
      final response = await dio.get('/movie/$movieId/credits');

      final castResponse = CreditsResponse.fromJson(response.data);

      return DataResponse(
          success: true,
          data: castResponse.cast
              .map((cast) => ActorMapper.castToEntity(cast))
              .toList());
    } catch (_) {
      return DataResponse(success: false);
    }
  }
}
