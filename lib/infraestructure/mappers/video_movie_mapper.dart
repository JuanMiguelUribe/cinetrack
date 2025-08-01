import 'package:movieflex/infraestructure/models/movieDb/moviedb_videos.dart';

import '../../domain/entities/video_movie.dart';

class VideoMapper {
  static VideoMovie moviedbVideoToEntity(Result moviedbVideo) => VideoMovie(
    id: moviedbVideo.id,
    name: moviedbVideo.name,
    youtubeKey: moviedbVideo.key,
    publishedAt: moviedbVideo.publishedAt,
    site: moviedbVideo.site,
    type: moviedbVideo.type ?? "CLIP",
  );
}
