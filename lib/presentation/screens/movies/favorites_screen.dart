import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:cinemapedia_app/presentation/widgets/movies/movie_mazonry.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoritesScreen extends ConsumerStatefulWidget {
  static const name = 'favorites-screen';
  final Function(bool value) setLoading;

  const FavoritesScreen({super.key, required this.setLoading});

  @override
  ConsumerState<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends ConsumerState<FavoritesScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      load();
    });
  }

  void load() async {
    widget.setLoading(true);
    await ref.read(movieFavoritesProvider.notifier).loadNextPage();
    widget.setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(movieFavoritesProvider).values.toList();

    if (movies.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.favorite_outline_sharp, size: 60, color: colors.primary),
            Text('Ohhh no!!',
                style: TextStyle(fontSize: 30, color: colors.primary)),
            Text('doNotHaveFavoriteMovies'.tr(),
                style: const TextStyle(
                  fontSize: 20,
                )),
            const SizedBox(height: 20),
            FilledButton.tonal(
                onPressed: () => context.push('/home/0'),
                child: Text('startSearch'.tr()))
          ],
        ),
      );
    }

    return MovieMasonry(
        movies: movies,
        loadNextPage: () =>
            ref.read(movieFavoritesProvider.notifier).loadNextPage());
  }
}
