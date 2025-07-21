import 'package:dio/dio.dart';
import 'package:cinetrack/domain/datasources/movies_datasource.dart';
import 'package:cinetrack/infraestructure/models/movieDb/moviedb_response.dart';
import 'package:cinetrack/infraestructure/mappers/movie_mapper.dart';
import 'package:cinetrack/config/constants/environment.dart';
import 'package:cinetrack/domain/entities/movie.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {'api_key': Environment.movieDbKey, 'language': "es-MX"},
    ),
  );
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get(
      "/movie/now_playing",
      queryParameters: {'page': page},
    );
    final movieDbResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDbResponse.results
        .where((moviedb) => moviedb.posterPath != "no-poster")
        .map((moviedb) => MovieMapper.movieDBtoEntity(moviedb))
        .toList();
    return movies;
  }
}
