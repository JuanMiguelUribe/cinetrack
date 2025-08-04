import 'package:movieflex/domain/entities/movie.dart';
import 'package:movieflex/domain/entities/movie_details.dart' show MovieDetails;
import 'package:movieflex/domain/entities/video_movie.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> getUpcoming({int page = 1});
  Future<List<Movie>> getTopRated({int page = 1});

  Future<MovieDetails> getMovieById(String id);

  Future<List<Movie>> searchMovies(String query);
  Future<List<VideoMovie>> getYoutubeVideosById(int movieId);
  Future<List<VideoMovie>> getYoutubeVideosByIdTvShow(int tvshowId);
  Future<List<Movie>> getRecomendationsById(String movieId, {int page = 1});
  Future<List<Movie>> discoverMovies({int page = 1});
}
