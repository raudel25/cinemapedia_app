import 'package:cinemapedia_app/config/utils/data_response.dart';
import 'package:cinemapedia_app/domain/entities/actor.dart';
import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsByMovieProvider =
    StateNotifierProvider<ActorsByMovieNotifier, Map<String, List<Actor>>>(
        (ref) {
  final actorsRepository = ref.watch(actorRepositoryProvider);

  return ActorsByMovieNotifier(
      getActors: actorsRepository.getActorsByMovie, ref: ref);
});

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final Future<DataResponse<List<Actor>>> Function(String movieId,
      {String? language}) getActors;
  final Ref ref;

  final Map<(String, String), List<Actor>> _localeState = {};

  ActorsByMovieNotifier({required this.getActors, required this.ref})
      : super({});

  Future<void> loadActors(String movieId) async {
    final locale = ref.read(localeProvider).toString();

    if (_localeState[(movieId, locale)] != null) {
      state = {...state, movieId: _localeState[(movieId, locale)]!};
      return;
    }

    final response = await getActors(movieId, language: locale);
    if (!response.success) return;

    state = {...state, movieId: response.data!};
    _localeState[(movieId, locale)] = response.data!;
  }
}
