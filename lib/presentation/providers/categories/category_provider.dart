import 'package:cinemapedia_app/config/utils/data_response.dart';
import 'package:cinemapedia_app/domain/entities/category.dart';
import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:riverpod/riverpod.dart';

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, List<Category>>((ref) {
  return CategoryNotifier(
      load: ref.read(categoryRepositoryProvider).getCategories, ref: ref);
});

class CategoryNotifier extends StateNotifier<List<Category>> {
  Future<DataResponse<List<Category>>> Function({String? language}) load;
  Ref ref;
  CategoryNotifier({required this.load, required this.ref}) : super([]);

  Future<void> loadCategories() async {
    final response = await load(language: ref.read(localeProvider).toString());
    state = response.data ?? [];
  }
}
