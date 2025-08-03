import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieflex/domain/entities/tv_shows.dart';
import 'package:movieflex/domain/respositories/tvshows_repository.dart';
import 'package:movieflex/presentation/providers/providers.dart';

class RecommendationsNotifierTvShow extends StateNotifier<List<TvShow>> {
  final TvShowsDBRepository repository;

  int _currentPage = 1;
  bool _isLoading = false;
  final String tvshowId;

  RecommendationsNotifierTvShow({
    required this.repository,
    required this.tvshowId,
  }) : super([]) {
    loadNextPage();
  }

  Future<void> loadNextPage() async {
    if (_isLoading) return;
    _isLoading = true;

    final movies = await repository.getRecomendationsTvShowById(
      tvshowId,
      page: _currentPage,
    );

    state = [...state, ...movies];

    _currentPage++;
    _isLoading = false;
  }
}

final recommendationsNotifierProviderTvShow =
    StateNotifierProvider.family<
      RecommendationsNotifierTvShow,
      List<TvShow>,
      String
    >((ref, tvshowId) {
      final repository = ref.watch(tvshowsRepositoryProvider);
      return RecommendationsNotifierTvShow(
        tvshowId: tvshowId,
        repository: repository,
      );
    });
