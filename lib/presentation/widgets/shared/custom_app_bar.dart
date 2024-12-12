import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/providers/deleagtes/search_movie_delegate.dart';
import 'package:cinemapedia_app/presentation/providers/movies/movie_repository_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Icon(
                  Icons.movie_outlined,
                  color: colors.primary,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Cinemapedia',
                  style: titleStyle,
                ),
                const Spacer(),
                IconButton(
                    onPressed: () => showSearch<Movie?>(
                            context: context,
                            delegate: SearchMovieDelegate(
                                searchMovie: (query) => ref
                                    .read(movieRepositoryProvider)
                                    .searchMovie(query,
                                        language: context.locale
                                            .toString()))).then((movie) {
                          if (movie != null) {
                            context.push('/home/0/movie/${movie.id}');
                          }
                        }),
                    icon: const Icon(Icons.search))
              ],
            ),
          ),
        ));
  }
}
