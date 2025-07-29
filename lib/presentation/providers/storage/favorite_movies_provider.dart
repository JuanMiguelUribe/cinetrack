import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieflex/domain/entities/movie.dart';
import 'package:movieflex/domain/respositories/local_storage_repository.dart';
import 'package:movieflex/presentation/providers/providers.dart';

final favoriteMoviesProvider =
    StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
      final localStorageRepository = ref.watch(localStorageRepositoryProvider);
      return StorageMoviesNotifier(
        localStorageRepository: localStorageRepository,
      );
    });

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  final LocalStorageRepository localStorageRepository;
  StorageMoviesNotifier({required this.localStorageRepository}) : super({});

  Future<List<Movie>> loadNextPage() async {
    final movies = await localStorageRepository.loadFavoriteMovies(
      offset: page * 10,
    );
    page++;

    final tempMoviesMap = <int, Movie>{};

    for (final movie in movies) {
      tempMoviesMap[movie.id] = movie;
    }
    // final tempMoviesList = tempMoviesMap.toList();

    state = {...state, ...tempMoviesMap};
    return movies;
  }
}
