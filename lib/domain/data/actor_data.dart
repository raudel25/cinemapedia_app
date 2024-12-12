import 'package:cinemapedia_app/config/utils/data_response.dart';
import 'package:cinemapedia_app/domain/entities/actor.dart';

abstract class ActorData {
  Future<DataResponse<List<Actor>>> getActorsByMovie(String movieId,
      {String? language});
}
