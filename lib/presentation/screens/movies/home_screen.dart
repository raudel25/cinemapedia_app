import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:cinemapedia_app/presentation/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
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
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    
    final moviesSlideShow = ref.watch(moviesSlideshowProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppBar(),
            titlePadding: EdgeInsets.zero,
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                childCount: 1,
                (context, index) => Column(
                      children: [
                        MovieSlideShow(movies: moviesSlideShow),
                        MovieHorizontalListView(
                          title: 'inMovieTheaters'.tr(),
                          movies: nowPlayingMovies,
                          loadNextPage: () => ref
                              .read(nowPlayingMoviesProvider.notifier)
                              .loadNextPage(),
                        ),
                        MovieHorizontalListView(
                          title: 'popular'.tr(),
                          movies: popularMovies,
                          loadNextPage: () => ref
                              .read(popularMoviesProvider.notifier)
                              .loadNextPage(),
                        ),
                        MovieHorizontalListView(
                          title: 'upcoming'.tr(),
                          movies: upcomingMovies,
                          loadNextPage: () => ref
                              .read(upcomingMoviesProvider.notifier)
                              .loadNextPage(),
                        ),
                        MovieHorizontalListView(
                          title: 'topRated'.tr(),
                          movies: topRatedMovies,
                          loadNextPage: () => ref
                              .read(topRatedMoviesProvider.notifier)
                              .loadNextPage(),
                        )
                      ],
                    )))
      ],
    );
  }
}
