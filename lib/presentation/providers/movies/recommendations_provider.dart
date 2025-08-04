import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieflex/domain/entities/movie.dart';
import 'package:movieflex/domain/respositories/movies_repository.dart';
import 'package:movieflex/presentation/providers/movies/movies_respository_provider.dart';

class RecommendationsNotifier extends StateNotifier<List<Movie>> {
  final MoviesRepository repository;

  int _currentPage = 1;
  bool _isLoading = false;
  final String movieId;

  RecommendationsNotifier({required this.repository, required this.movieId})
    : super([]) {
    loadNextPage();
  }

  Future<void> loadNextPage() async {
    if (_isLoading) return;
    _isLoading = true;

    try {
      final movies = await repository.getRecomendationsById(
        movieId,
        page: _currentPage,
      );

      // Si viene vacío, asumimos que no hay más páginas
      if (movies.isEmpty) {
        _isLoading = false;
        return;
      }

      state = [...state, ...movies];
      _currentPage++;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
      } else {
        rethrow; // Para otros errores, lo lanzamos de nuevo
      }
    } finally {
      _isLoading = false;
    }
  }
}

final recommendationsNotifierProvider =
    StateNotifierProvider.family<RecommendationsNotifier, List<Movie>, String>((
      ref,
      movieId,
    ) {
      final repository = ref.watch(movieRepositoryProvider);
      return RecommendationsNotifier(movieId: movieId, repository: repository);
    });
