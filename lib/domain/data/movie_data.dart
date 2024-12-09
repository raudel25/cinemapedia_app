import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/config/utils/data_response.dart';

abstract class MovieData {
  Future<DataResponse<List<Movie>>> getNowPlaying(
      {int page = 1, String? language});
}
