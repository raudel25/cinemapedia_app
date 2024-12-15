import 'package:cinemapedia_app/domain/entities/category.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:cinemapedia_app/presentation/widgets/movies/movie_mazonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  static const name = 'categories-screen';

  final Function(bool value) setLoading;
  final String? categoryName;

  const CategoriesScreen(
      {super.key, required this.setLoading, required this.categoryName});

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen> {
  int? selectedCategory;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      load();
    });
  }

  void load() async {
    var categories = ref.read(categoryProvider);

    widget.setLoading(true);

    if (categories.isEmpty) {
      await ref.read(categoryProvider.notifier).loadCategories();
    }

    categories = ref.read(categoryProvider);
    await setCategory(widget.categoryName == null
        ? categories.first.id
        : categories.firstWhere((e) => e.name == widget.categoryName).id);

    widget.setLoading(false);
  }

  Future setCategory(int id) async {
    setState(() {
      selectedCategory = id;
    });
    final movies = ref.watch(moviesByCategoryProvider(selectedCategory!));

    if (movies.isNotEmpty) return;

    await ref.read(moviesByCategoryProvider(id).notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);
    final movies = selectedCategory != null
        ? ref.watch(moviesByCategoryProvider(selectedCategory!))
        : <Movie>[];

    return Column(
      children: [
        SizedBox(
          height: 100,
          child: _CategoriesSelector(
            selectedCategory: selectedCategory ?? 0,
            onChanged: (id) async {
              widget.setLoading(true);
              await setCategory(id);
              widget.setLoading(false);
            },
            categories: categories,
          ),
        ),
        Expanded(
            child: MovieMasonry(
                movies: movies,
                loadNextPage: selectedCategory != null
                    ? ref
                        .watch(moviesByCategoryProvider(selectedCategory!)
                            .notifier)
                        .loadNextPage
                    : () {}))
      ],
    );
  }
}

class _CategoriesSelector extends StatelessWidget {
  final List<Category> categories;
  final int selectedCategory;
  final Function(int index) onChanged;
  const _CategoriesSelector(
      {required this.categories,
      required this.onChanged,
      required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () => onChanged(categories[index].id),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Chip(
                    label: Text(
                      categories[index].name,
                      style: TextStyle(
                        color: categories[index].id == selectedCategory
                            ? isDarkMode
                                ? Colors.black
                                : Colors.white
                            : null,
                        fontWeight: categories[index].id == selectedCategory
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    backgroundColor: categories[index].id == selectedCategory
                        ? colorScheme.primary
                        : null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              )),
    );
  }
}
