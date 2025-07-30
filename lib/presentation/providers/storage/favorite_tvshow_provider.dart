import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieflex/domain/entities/tv_shows.dart';
import 'package:movieflex/domain/respositories/local_storage_repository.dart';
import 'package:movieflex/presentation/providers/providers.dart';

final favoriteTvShowProvider =
    StateNotifierProvider<TvShowStorageNotifier, Map<int, TvShow>>((ref) {
      final localStorageRepository = ref.watch(localStorageRepositoryProvider);
      return TvShowStorageNotifier(
        localStorageRepository: localStorageRepository,
      );
    });

class TvShowStorageNotifier extends StateNotifier<Map<int, TvShow>> {
  int page = 0;
  final LocalStorageRepository localStorageRepository;
  TvShowStorageNotifier({required this.localStorageRepository}) : super({});

  Future<List<TvShow>> loadNextPage() async {
    final tvShows = await localStorageRepository.loadFavoriteTvShows(
      offset: page * 10,
      limit: 20,
    );
    page++;

    final tempMap = <int, TvShow>{};
    for (final show in tvShows) {
      tempMap[show.id] = show;
    }

    state = {...state, ...tempMap};
    return tvShows;
  }

  Future<void> toggleFavorite(TvShow tvshow) async {
    await localStorageRepository.toggleFavoriteTvShow(tvshow);
    final bool isTvshowInFavorites = state[tvshow.id] != null;

    if (isTvshowInFavorites) {
      state.remove(tvshow.id);
      state = {...state};
    } else {
      state = {...state, tvshow.id: tvshow};
    }
  }
}
