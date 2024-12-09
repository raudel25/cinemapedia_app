import 'package:cinemapedia_app/infraestructure/data/movie_moviedb_data.dart';
import 'package:cinemapedia_app/infraestructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieRepositoryProvider =
    Provider((ref) => MovieRepositoryImpl(data: MovieMovieDbData()));
