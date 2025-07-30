import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieflex/domain/entities/video_movie.dart';
import 'package:movieflex/presentation/providers/movies/movies_respository_provider.dart';

final FutureProviderFamily<List<VideoMovie>, int> videosFromMovieProvider =
    FutureProvider.family((ref, int movieId) {
      final movieRepository = ref.watch(movieRepositoryProvider);
      return movieRepository.getYoutubeVideosById(movieId);
    });
