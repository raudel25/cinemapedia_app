import 'package:cinemapedia_app/domain/data/movie_data.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/domain/repositories/movie_repository.dart';
import 'package:cinemapedia_app/utils/data_response.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieData data;

  MovieRepositoryImpl({required this.data});

  @override
  Future<DataResponse<List<Movie>>> getNowPlaying({int page = 1}) =>
      data.getNowPlaying(page: page);
}
