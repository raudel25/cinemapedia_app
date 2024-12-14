import 'package:cinemapedia_app/domain/data/local_data.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarData extends LocalData {
  late Future<Isar> db;

  IsarData() {
    db = openDb();
  }

  Future<Isar> openDb() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open([MovieSchema], directory: dir.path);
    }

    return Future.value(Isar.getInstance());
  }

  Future<Movie?> _movieFavorite(int movieId, Isar isar) =>
      isar.movies.filter().idEqualTo(movieId).findFirst();

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await db;

    return await _movieFavorite(movieId, isar) != null;
  }

  @override
  Future<List<Movie>> loadMovies({int page = 1, int size = 10}) async {
    final isar = await db;

    return await isar.movies
        .where()
        .offset((page - 1) * size)
        .limit(size)
        .findAll();
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;

    final movieIsar = await _movieFavorite(movie.id, isar);
    if (movieIsar != null) {
      await isar
          .writeTxn(() async => await isar.movies.delete(movieIsar.isarId));
    } else {
      await isar.writeTxn(() async => await isar.movies.put(movie));
    }
  }
}
