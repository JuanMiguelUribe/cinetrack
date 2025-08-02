import 'package:movieflex/domain/entities/movie_details.dart';
import 'package:movieflex/domain/entities/video_movie.dart';
import 'package:movieflex/infraestructure/mappers/video_movie_mapper.dart';
import 'package:movieflex/infraestructure/models/movieDb/movie_details.dart';
import 'package:dio/dio.dart';
import 'package:movieflex/domain/datasources/movies_datasource.dart';
import 'package:movieflex/infraestructure/models/movieDb/moviedb_response.dart';
import 'package:movieflex/infraestructure/mappers/movie_mapper.dart';
import 'package:movieflex/config/constants/environment.dart';
import 'package:movieflex/domain/entities/movie.dart';
import 'package:movieflex/infraestructure/models/movieDb/moviedb_videos.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {'api_key': Environment.movieDbKey, 'language': "en"},
      responseType: ResponseType.json,
    ),
  );

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDbResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDbResponse.results
        .where((moviedb) => moviedb.posterPath != "no-poster")
        .map((moviedb) => MovieMapper.movieDBtoEntity(moviedb))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      "/movie/now_playing",
      queryParameters: {'page': page},
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get(
      "/movie/popular",
      queryParameters: {'page': page},
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get(
      "/movie/top_rated",
      queryParameters: {'page': page},
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get(
      "/movie/upcoming",
      queryParameters: {'page': page},
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<MovieDetails> getMovieById(String id) async {
    final response = await dio.get("/movie/$id");
    if (response.statusCode != 200) {
      throw Exception("Error fetching movie details");
    }

    final movieDetailsFromApi = MovieDetailsResponse.fromJson(
      response.data,
    ); // <- usar el modelo
    final MovieDetails movie = MovieMapper.movieDetailsToEntity(
      movieDetailsFromApi,
    );
    return movie;
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return [];
    final response = await dio.get(
      "/search/movie",
      queryParameters: {
        'query': query,
        'api_key': Environment.movieDbKey,
        'language': "en",
      },
    );
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<VideoMovie>> getYoutubeVideosById(int movieId) async {
    final response = await dio.get('/movie/$movieId/videos');
    final moviedbVideosReponse = MoviedbVideosResponse.fromJson(response.data);
    final videos = <VideoMovie>[];
    for (final moviedbVideo in moviedbVideosReponse.results) {
      if (moviedbVideo.site == 'YouTube') {
        final video = VideoMapper.moviedbVideoToEntity(moviedbVideo);
        videos.add(video);
      }
    }

    return videos;
  }

  @override
  Future<List<VideoMovie>> getYoutubeVideosByIdTvShow(int tvshowId) async {
    final response = await dio.get('/tv/$tvshowId/videos');
    final moviedbVideosReponse = MoviedbVideosResponse.fromJson(response.data);
    final videos = <VideoMovie>[];
    for (final moviedbVideo in moviedbVideosReponse.results) {
      if (moviedbVideo.site == 'YouTube') {
        final video = VideoMapper.moviedbVideoToEntity(moviedbVideo);
        videos.add(video);
      }
    }

    return videos;
  }

  @override
  Future<List<Movie>> getRecomendationsById(
    String movieId, {
    int page = 1,
  }) async {
    final response = await dio.get(
      '/movie/$movieId/recommendations',
      queryParameters: {'page': page},
    );
    if (response.statusCode != 200) {
      throw Exception("Error fetching movie details");
    }

    return _jsonToMovies(response.data);
  }
}
