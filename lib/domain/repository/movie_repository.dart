import 'package:cinemapedia_app/domain/entities/movie.dart';

abstract class MovieData {
  Future<List<Movie>> getNowPlaying({int page = 1});
}
