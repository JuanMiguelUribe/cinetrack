import 'package:cinetrack/infraestructure/models/movieDb/movie_details.dart';
import 'package:dio/dio.dart';
import 'package:cinetrack/domain/datasources/movies_datasource.dart';
import 'package:cinetrack/infraestructure/models/movieDb/moviedb_response.dart';
import 'package:cinetrack/infraestructure/mappers/movie_mapper.dart';
import 'package:cinetrack/config/constants/environment.dart';
import 'package:cinetrack/domain/entities/movie.dart';

import '../models/movieDb/movie_credits.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {'api_key': Environment.movieDbKey, 'language': "es-MX"},
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
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get("/movie/$id");
    if (response.statusCode != 200) {
      throw Exception("Error fetching movie details");
    }

    final movieDetails = MovieDetails.fromJson(response.data);
    final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);
    return movie;
  }

  // Future<Movie> getCreditsById(String id) async {
  //   final response = await dio.get("/movie/$id/credits");
  //   if (response.statusCode != 200) {
  //     throw Exception("Error fetching movie credits");
  //   }

  //   final movieCredits = MovieCredits.fromJson(response.data);
  //   final Movie movie = MovieMapper.movieDetailsToEntity(movieCredits);
  //   return movie;
  // }
}
