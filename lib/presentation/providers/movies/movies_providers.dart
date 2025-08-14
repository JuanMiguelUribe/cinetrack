import 'dart:math';

import 'package:movieflex/domain/entities/movie.dart';
import 'package:movieflex/presentation/providers/movies/movies_respository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
      final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
      return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
    });
final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
      final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopular;
      return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
    });
final upcomingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
      final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpcoming;
      return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
    });
final topRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
      final fetchMoreMovies = ref.watch(movieRepositoryProvider).getTopRated;
      return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
    });
final discoverMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
      final fetchMoreMovies = ref.watch(movieRepositoryProvider).discoverMovies;
      return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
    });

typedef MovieCallBack = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;
  bool _disposed = false;

  final MovieCallBack fetchMoreMovies;

  MoviesNotifier({required this.fetchMoreMovies}) : super([]) {
    _init();
  }

  void _init() {
    loadNextPage();
    loadNextRandomPage();
    loadNextRandomPageAdded();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  Future<void> loadNextPage() async {
    if (isLoading || _disposed) return;

    isLoading = true;
    currentPage++;

    final List<Movie> movies = await fetchMoreMovies(page: currentPage);

    if (_disposed) return; // Chequea después del await también

    state = [...state, ...movies];
    await Future.delayed(const Duration(milliseconds: 500));

    isLoading = false;
  }

  //*se carga paginas  siguiente, pero consecuente
  Future<void> loadNextRandomPage() async {
    if (isLoading || _disposed) return;
    isLoading = true;

    currentPage = Random().nextInt(498) + 1;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    if (_disposed) return;

    state = movies;
    await Future.delayed(const Duration(milliseconds: 500));

    isLoading = false;
  }

  //*Se carga la pagina siguiente
  Future<void> loadNextRandomPageAdded() async {
    if (isLoading || _disposed) return;
    isLoading = true;

    currentPage = Random().nextInt(498) + 1;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    if (_disposed) return;

    state = [...state, ...movies];

    await Future.delayed(const Duration(milliseconds: 500));

    isLoading = false;
  }

  //*Se carga otra pagina pero se agrega antes

  Future<void> loadPreviousRandomPageAdded() async {
    if (isLoading || _disposed) return;
    isLoading = true;

    final int randomPage = Random().nextInt(498) + 1;
    final List<Movie> movies = await fetchMoreMovies(page: randomPage);
    if (_disposed) return;

    state = [...movies, ...state];

    await Future.delayed(const Duration(milliseconds: 500));
    isLoading = false;
  }
}
