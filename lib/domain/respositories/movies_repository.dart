import 'package:movieflex/domain/entities/movie.dart';
import 'package:movieflex/domain/entities/movie_details.dart' show MovieDetails;

abstract class MoviesRepository {
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> getUpcoming({int page = 1});
  Future<List<Movie>> getTopRated({int page = 1});

  Future<MovieDetails> getMovieById(String id);

  Future<List<Movie>> searchMovies(String query);
}
