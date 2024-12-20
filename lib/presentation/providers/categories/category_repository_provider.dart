import 'package:cinemapedia_app/infrastructure/data/category_moviedb_data.dart';
import 'package:cinemapedia_app/infrastructure/repositories/category_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryRepositoryProvider =
    Provider((ref) => CategoryRepositoryImpl(data: CategoryMovieDbData()));
