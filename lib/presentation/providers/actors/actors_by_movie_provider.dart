import 'package:cinemapedia_app/config/utils/data_response.dart';
import 'package:cinemapedia_app/domain/entities/actor.dart';
import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>(
        (ref) {
  final actorsRepository = ref.watch(actorRepositoryProvider);

  final locale = ref.read(localeProvider.notifier).state;

  return ActorsByMovieNotifier(
      getActors: (String movieId) => actorsRepository.getActorsByMovie(movieId,
          language: locale.toString()));
});

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final Future<DataResponse<List<Actor>>> Function(String movieId) getActors;

  ActorsByMovieNotifier({
    required this.getActors,
  }) : super({});

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) return;

    final response = await getActors(movieId);
    if (!response.success) return;

    state = {...state, movieId: response.data!};
  }
}
