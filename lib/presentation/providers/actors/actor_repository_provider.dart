import 'package:cinemapedia_app/infrastructure/data/actor_moviedb_data.dart';
import 'package:cinemapedia_app/infrastructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorRepositoryProvider =
    Provider((ref) => ActorRepositoryImpl(data: ActorMovieDbData()));
