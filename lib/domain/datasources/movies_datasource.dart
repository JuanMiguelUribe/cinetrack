import 'package:movieflex/domain/entities/movie.dart';
import 'package:movieflex/domain/entities/movie_details.dart';
import 'package:movieflex/domain/entities/video_movie.dart';

abstract class MoviesDatasource {
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> getUpcoming({int page = 1});
  Future<List<Movie>> getTopRated({int page = 1});

  Future<MovieDetails> getMovieById(String id);

  Future<List<Movie>> searchMovies(String query);
  Future<List<VideoMovie>> getYoutubeVideosById(int movieId);
  Future<List<VideoMovie>> getYoutubeVideosByIdTvShow(int tvshowId);

  Future<List<Movie>> getRecomendationsById(int movieId, {int page = 1});
}
