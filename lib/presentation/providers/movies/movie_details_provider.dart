import 'package:cinetrack/domain/entities/movie.dart';
import 'package:cinetrack/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
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

typedef GetMovieCallBack = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallBack getMovie;
  MovieMapNotifier({required this.getMovie}) : super({});

  Future<void> loadMovie(String movieID) async {
    if (state[movieID] != null) return;
    final movie = await getMovie(movieID);
    state = {...state, movieID: movie};
  }
}
