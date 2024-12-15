import 'package:cinemapedia_app/config/utils/data_response.dart';
import 'package:cinemapedia_app/domain/data/actor_data.dart';
import 'package:cinemapedia_app/domain/entities/actor.dart';
import 'package:cinemapedia_app/domain/repositories/actor_repository.dart';

class ActorRepositoryImpl extends ActorRepository {
  final ActorData data;

  ActorRepositoryImpl({required this.data});

  @override
  Future<DataResponse<List<Actor>>> getActorsByMovie(String movieId,
          {String? language}) =>
      data.getActorsByMovie(movieId, language: language);
}
