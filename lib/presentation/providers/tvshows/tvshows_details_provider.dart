import 'package:cinetrack/domain/entities/tv_show_details.dart';
import 'package:cinetrack/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tvshowsInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, TvShowDetails>>((ref) {
      final tvshowRepository = ref.watch(tvshowsRepositoryProvider);
      return MovieMapNotifier(getTvShow: tvshowRepository.getTvShowById);
    });

/*
{
  "505652": "Tvshow()",
  "505653": "Tvshow()",
  "505654": "Tvshow()",
  "505655": "Tvshow()",
 */

typedef GetMovieCallBack = Future<TvShowDetails> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, TvShowDetails>> {
  final GetMovieCallBack getTvShow;
  MovieMapNotifier({required this.getTvShow}) : super({});

  Future<void> loadMovie(String tvShowId) async {
    if (state[tvShowId] != null) return;
    final movie = await getTvShow(tvShowId);
    state = {...state, tvShowId: movie};
  }
}
