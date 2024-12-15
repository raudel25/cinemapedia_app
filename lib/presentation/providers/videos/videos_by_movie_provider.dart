import 'package:cinemapedia_app/config/utils/data_response.dart';
import 'package:cinemapedia_app/domain/entities/video.dart';
import 'package:cinemapedia_app/presentation/providers/locale/locale_provider.dart';
import 'package:cinemapedia_app/presentation/providers/movies/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final FutureProviderFamily<DataResponse<List<Video>>, int>
    videosFromMovieProvider = FutureProvider.family((ref, int movieId) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return movieRepository.getYouTubeVideosById(movieId,
      language: ref.read(localeProvider).toString());
});
