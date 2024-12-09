import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/utils/data_response.dart';

abstract class MovieRepository {
  Future<DataResponse<List<Movie>>> getNowPlaying({int page = 1});
}
