import 'package:cinemapedia_app/domain/entities/category.dart';
import 'package:cinemapedia_app/infraestructure/models/category_response.dart';

class CategoryMapper {
  static Category categoryMovieDbToEntity(CategoryMovieDb category) =>
      Category(id: category.id, name: category.name);
}
