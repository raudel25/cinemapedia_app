import 'package:cinemapedia_app/config/utils/data_response.dart';
import 'package:cinemapedia_app/domain/data/category_data.dart';
import 'package:cinemapedia_app/domain/entities/category.dart';
import 'package:cinemapedia_app/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryData data;

  CategoryRepositoryImpl({required this.data});

  @override
  Future<DataResponse<List<Category>>> getCategories({String? language}) =>
      data.getCategories(language: language);
}
