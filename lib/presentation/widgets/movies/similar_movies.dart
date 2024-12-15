import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/providers/movies/movie_providers.dart';
import 'package:cinemapedia_app/presentation/widgets/movies/movie_horizontal_list_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SimilarMovies extends ConsumerWidget {
  final int movieId;

  const SimilarMovies({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final similarMoviesFuture = ref.watch(similarMoviesProvider(movieId));

    return similarMoviesFuture.when(
      data: (movies) => _Suggestions(movies: movies.data ?? []),
      error: (_, __) => Center(child: Text('unexpectedError'.tr())),
      loading: () =>
          const Center(child: CircularProgressIndicator(strokeWidth: 2)),
    );
  }
}

class _Suggestions extends StatelessWidget {
  final List<Movie> movies;

  const _Suggestions({required this.movies});

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) return const SizedBox();

    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: 50),
      child: MovieHorizontalListView(title: 'suggestions'.tr(), movies: movies),
    );
  }
}
