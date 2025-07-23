import 'package:cinetrack/domain/entities/tv_shows.dart';
import 'package:cinetrack/presentation/providers/tvshows/tvshows_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final airingTvShowProvider =
    StateNotifierProvider<TvShowsNotifier, List<TvShow>>((ref) {
      final fetchMoreTvShows = ref
          .watch(tvshowsRepositoryProvider)
          .getTvShowsAiring;
      return TvShowsNotifier(fetchMoreTvshows: fetchMoreTvShows);
    });
final onTheAirTvShowProvider =
    StateNotifierProvider<TvShowsNotifier, List<TvShow>>((ref) {
      final fetchMoreTvShows = ref
          .watch(tvshowsRepositoryProvider)
          .getTvShowsOnTheAir;
      return TvShowsNotifier(fetchMoreTvshows: fetchMoreTvShows);
    });
final popularTvShowProvider =
    StateNotifierProvider<TvShowsNotifier, List<TvShow>>((ref) {
      final fetchMoreTvShows = ref
          .watch(tvshowsRepositoryProvider)
          .getTvShowsPopular;
      return TvShowsNotifier(fetchMoreTvshows: fetchMoreTvShows);
    });
final topRatedTvShowProvider =
    StateNotifierProvider<TvShowsNotifier, List<TvShow>>((ref) {
      final fetchMoreTvShows = ref
          .watch(tvshowsRepositoryProvider)
          .getTvShowsTopRated;
      return TvShowsNotifier(fetchMoreTvshows: fetchMoreTvShows);
    });

typedef TvShowCallBack = Future<List<TvShow>> Function({int page});

class TvShowsNotifier extends StateNotifier<List<TvShow>> {
  int currentPage = 0;
  bool isLoading = false;

  TvShowCallBack fetchMoreTvshows;

  TvShowsNotifier({required this.fetchMoreTvshows}) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;

    isLoading = true;
    currentPage++;
    final List<TvShow> tvshows = await fetchMoreTvshows(page: currentPage);
    state = [...state, ...tvshows];
    await Future.delayed(const Duration(milliseconds: 500));

    isLoading = false;
  }
}
