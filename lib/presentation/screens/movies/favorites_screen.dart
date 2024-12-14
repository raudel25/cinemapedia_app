import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

    return ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(movies[index].title));
        });
  }
}
