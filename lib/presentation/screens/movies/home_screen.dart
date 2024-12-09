import 'package:cinemapedia_app/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia_app/presentation/widgets/shared/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

    return Column(
      children: [
        const CustomAppBar(),
        Expanded(
          child: ListView.builder(
              itemCount: nowPlayingMovies.length,
              itemBuilder: (context, index) {
                final movie = nowPlayingMovies[index];

                return ListTile(
                  title: Text(movie.title),
                  subtitle: Text(movie.overview),
                );
              }),
        ),
      ],
    );
  }
}
