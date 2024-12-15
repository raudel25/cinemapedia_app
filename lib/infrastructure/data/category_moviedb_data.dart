import 'package:cinemapedia_app/config/constants/environment.dart';
import 'package:cinemapedia_app/config/utils/data_response.dart';
import 'package:cinemapedia_app/domain/data/category_data.dart';
import 'package:cinemapedia_app/domain/entities/category.dart';
import 'package:cinemapedia_app/infrastructure/mappers/category_mapper.dart';
import 'package:cinemapedia_app/infrastructure/models/category_response.dart';
import 'package:dio/dio.dart';

class CategoryMovieDbData extends CategoryData {
  final dio = Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
    'api_key': Environment.theMovieDbKey,
  }));

  @override
  Future<DataResponse<List<Category>>> getCategories({String? language}) async {
    Map<String, dynamic> query = {};

    if (language != null) query['language'] = language.replaceAll(r'_', '-');

    try {
      final response = await dio.get('/genre/movie/list');

      final genresResponse = GenresResponse.fromJson(response.data);

      return DataResponse(
          success: true,
          data: genresResponse.genres
              .map((c) => CategoryMapper.categoryMovieDbToEntity(c))
              .toList());
    } catch (_) {
      return DataResponse(success: false);
    }
  }
}
