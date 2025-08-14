import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieflex/domain/entities/video_movie.dart';
import 'package:movieflex/presentation/providers/movies/movies_respository_provider.dart';

enum MediaType { movie, tv }

final videosProvider =
    FutureProvider.family<List<VideoMovie>, ({int id, MediaType type})>((
      ref,
      args,
    ) async {
      final repo = ref.watch(movieRepositoryProvider);

      // Obtiene todos los videos según el tipo
      final videos = args.type == MediaType.movie
          ? await repo.getYoutubeVideosById(args.id)
          : await repo.getYoutubeVideosByIdTvShow(args.id);

      // Aquí limitas (por ejemplo, a 5) y puedes filtrar solo trailers oficiales
      final limitedVideos = videos
          .where((video) => video.site.toLowerCase() == 'youtube')
          .take(5)
          .toList();

      return limitedVideos;
    });
