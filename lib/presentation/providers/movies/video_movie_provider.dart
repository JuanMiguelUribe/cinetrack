import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieflex/domain/entities/video_movie.dart';
import 'package:movieflex/presentation/providers/movies/movies_respository_provider.dart';

enum MediaType { movie, tv }

final videosProvider =
    FutureProvider.family<List<VideoMovie>, ({int id, MediaType type})>((
      ref,
      args,
    ) {
      final repo = ref.watch(movieRepositoryProvider);

      return args.type == MediaType.movie
          ? repo.getYoutubeVideosById(args.id)
          : repo.getYoutubeVideosByIdTvShow(args.id);
    });
