import 'package:cinemapedia_app/infraestructure/data/isar_data.dart';
import 'package:cinemapedia_app/infraestructure/repositories/local_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localRepositoryProvider =
    Provider((ref) => LocalRepositoryImpl(data: IsarData()));
