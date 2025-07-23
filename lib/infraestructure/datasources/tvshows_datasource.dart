import 'package:cinetrack/domain/datasources/tvshows_datasources.dart';
import 'package:cinetrack/domain/entities/tv_shows.dart';
import 'package:cinetrack/infraestructure/models/movieDb/tvshowdb_response.dart';
import 'package:dio/dio.dart';
import 'package:cinetrack/config/constants/environment.dart';
import '../mappers/tvshow_mapper.dart';

class TvshowsDBDatasource extends TvShowsDBDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {'api_key': Environment.movieDbKey, 'language': "es-MX"},
    ),
  );

  List<TvShow> _jsonToTvShows(Map<String, dynamic> json) {
    final tvshowsDbResponse = TvShowsResponse.fromJson(json);

    final List<TvShow> tvshows = tvshowsDbResponse.results
        .map((tvshowdb) => TvshowMapper.tvshowDBtoEntity(tvshowdb))
        .toList();

    return tvshows;
  }

  @override
  Future<List<TvShow>> getTvShowsAiring({int page = 1}) async {
    final response = await dio.get(
      "/tv/airing_today",
      queryParameters: {'page': page},
    );
    return _jsonToTvShows(response.data);
  }

  @override
  Future<List<TvShow>> getTvShowsOnTheAir({int page = 1}) async {
    final response = await dio.get(
      "/tv/on_the_air",
      queryParameters: {'page': page},
    );
    return _jsonToTvShows(response.data);
  }

  @override
  Future<List<TvShow>> getTvShowsPopular({int page = 1}) async {
    final response = await dio.get(
      "/tv/popular",
      queryParameters: {'page': page},
    );
    return _jsonToTvShows(response.data);
  }

  @override
  Future<List<TvShow>> getTvShowsTopRated({int page = 1}) async {
    final response = await dio.get(
      "/tv/top_rated",
      queryParameters: {'page': page},
    );
    return _jsonToTvShows(response.data);
  }
}
