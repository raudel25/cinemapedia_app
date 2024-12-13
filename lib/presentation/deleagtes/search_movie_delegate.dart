import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia_app/config/utils/human_formats.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final Future<List<Movie>> Function(String query) searchMovie;

  final StreamController<List<Movie>> debouncedController =
      StreamController.broadcast();
  final StreamController<bool> isLoadingController =
      StreamController.broadcast();

  Timer? timer;
  List<Movie> initialMovies;
  String lastQuery;

  SearchMovieDelegate(
      {required this.searchMovie,
      required this.initialMovies,
      required this.lastQuery});

  void _onChangeQuery(String query) {
    if (timer?.isActive ?? false) timer!.cancel();
    if (query == lastQuery) return;

    lastQuery = query;

    if (!isLoadingController.isClosed) isLoadingController.add(true);
    timer = Timer(const Duration(milliseconds: 1000), () async {
      if (query.isEmpty) {
        if (!isLoadingController.isClosed) isLoadingController.add(false);
        return;
      }

      final movies = await searchMovie(query);
      if (!isLoadingController.isClosed) isLoadingController.add(false);

      initialMovies = movies;
      if (!debouncedController.isClosed) debouncedController.add(movies);
    });
  }

  @override
  void close(BuildContext context, Movie? result) {
    timer?.cancel();
    Future.wait([isLoadingController.close(), debouncedController.close()])
        .then((_) => super.close(context, result));
  }

  @override
  String get searchFieldLabel => 'searchMovie'.tr();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      // SpinPerfect(
      //     child: SpinPerfect(
      //   // duration: const Duration(seconds: 20),
      //   infinite: true,
      //   // spins: 10,
      //   child: IconButton(
      //     onPressed: () => query = '',
      //     icon: const Icon(Icons.refresh_rounded),
      //   ),
      // ))
      StreamBuilder<bool>(
        stream: isLoadingController.stream,
        builder: (context, snapshot) => snapshot.data ?? false
            ? SpinPerfect(
                child: SpinPerfect(
                // duration: const Duration(seconds: 20),
                infinite: true,
                // spins: 10,
                child: IconButton(
                  onPressed: () => query = '',
                  icon: const Icon(Icons.refresh_rounded),
                ),
              ))
            : FadeIn(
                animate: query.isNotEmpty,
                child: IconButton(
                    onPressed: () => query = '',
                    icon: const Icon(Icons.clear))),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestionsAndResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onChangeQuery(query);

    return buildSuggestionsAndResults();
  }

  Widget buildSuggestionsAndResults() => StreamBuilder(
      initialData: initialMovies,
      stream: debouncedController.stream,
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];

        return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) => _MovieItem(
                  movie: movies[index],
                  onSelected: close,
                ));
      });
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function(BuildContext context, Movie? movie) onSelected;

  const _MovieItem({required this.movie, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => onSelected(context, movie),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            // Image
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) =>
                      FadeIn(child: child),
                ),
              ),
            ),

            const SizedBox(width: 10),

            // Description
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyles.titleMedium),
                  (movie.overview.length > 100)
                      ? Text('${movie.overview.substring(0, 100)}...')
                      : Text(movie.overview),
                  Row(
                    children: [
                      Icon(Icons.star_half_rounded,
                          color: Colors.yellow.shade800),
                      const SizedBox(width: 5),
                      Text(
                        HumanFormats.numberDecimal(movie.voteAverage,
                            decimal: 1),
                        style: textStyles.bodyMedium!
                            .copyWith(color: Colors.yellow.shade900),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
