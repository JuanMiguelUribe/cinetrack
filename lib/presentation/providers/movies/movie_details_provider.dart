import 'package:movieflex/domain/entities/movie_details.dart';
import 'package:movieflex/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, MovieDetails>>((ref) {
      final movieRepository = ref.watch(movieRepositoryProvider);
      return MovieMapNotifier(getMovie: movieRepository.getMovieById);
    });

/*
{
  "505652": "Movie()",
  "505653": "Movie()",
  "505654": "Movie()",
  "505655": "Movie()",
 */

typedef GetMovieCallBack = Future<MovieDetails> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, MovieDetails>> {
  final GetMovieCallBack getMovie;
  MovieMapNotifier({required this.getMovie}) : super({});

  Future<void> loadMovie(String movieID) async {
    if (state[movieID] != null) return;
    final movie = await getMovie(movieID);
    state = {...state, movieID: movie};
  }
}
