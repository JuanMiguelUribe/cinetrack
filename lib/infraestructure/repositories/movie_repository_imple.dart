import 'package:movieflex/domain/datasources/movies_datasource.dart';
import 'package:movieflex/domain/entities/movie.dart';
import 'package:movieflex/domain/entities/movie_details.dart';
import 'package:movieflex/domain/entities/video_movie.dart';
import 'package:movieflex/domain/respositories/movies_repository.dart';

class MovieRepositoryImple extends MoviesRepository {
  final MoviesDatasource datasource;

  MovieRepositoryImple(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page: page);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return datasource.getUpcoming(page: page);
  }

  @override
  Future<MovieDetails> getMovieById(String id) {
    return datasource.getMovieById(id);
  }

  @override
  Future<List<Movie>> searchMovies(String query) {
    // o debugPrint(jsonEncode(results));

    return datasource.searchMovies(query);
  }

  @override
  Future<List<VideoMovie>> getYoutubeVideosById(int movieId) {
    return datasource.getYoutubeVideosById(movieId);
  }

  @override
  Future<List<VideoMovie>> getYoutubeVideosByIdTvShow(int tvshowId) {
    return datasource.getYoutubeVideosByIdTvShow(tvshowId);
  }

  @override
  Future<List<Movie>> getRecomendationsById(String movieId, {int page = 1}) {
    return datasource.getRecomendationsById(movieId, page: page);
  }

  @override
  Future<List<Movie>> discoverMovies({int? page}) {
    return datasource.discoverMovies(page: page);
  }
}
