import 'package:cinemapedia_app/config/utils/data_response.dart';
import 'package:cinemapedia_app/domain/entities/category.dart';

abstract class CategoryData {
  Future<DataResponse<List<Category>>> getCategories({String? language});
}
