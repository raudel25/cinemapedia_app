import 'package:cinemapedia_app/domain/entities/video.dart';
import 'package:cinemapedia_app/infrastructure/models/video_moviedb.dart';

class VideoMapper {
  static Video movieDbVideoToEntity(Result video) => Video(
      id: video.id,
      name: video.name,
      youTubeKey: video.key,
      publishedAt: video.publishedAt);
}
