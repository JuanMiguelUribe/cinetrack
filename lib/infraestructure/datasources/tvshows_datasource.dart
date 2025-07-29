import 'package:movieflex/domain/datasources/tvshows_datasources.dart';
import 'package:movieflex/domain/entities/tv_show_details.dart';
import 'package:movieflex/domain/entities/tv_shows.dart';
import 'package:movieflex/infraestructure/models/movieDb/tvshow_details_response.dart';
import 'package:movieflex/infraestructure/models/movieDb/tvshowdb_response.dart';
import 'package:dio/dio.dart';
import 'package:movieflex/config/constants/environment.dart';
import '../mappers/tvshow_mapper.dart';

class TvshowsDBDatasource extends TvShowsDBDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {'api_key': Environment.movieDbKey, 'language': "en"},
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

  @override
  Future<TvShowDetails> getTvShowById(String id) async {
    final response = await dio.get("/tv/$id");
    if (response.statusCode != 200) {
      throw Exception("Error fetching series details");
    }

    final tvshowDetails = TvShowsDetails.fromJson(response.data);
    final TvShowDetails tvShow = TvshowMapper.tvshowDetailsToEntity(
      tvshowDetails,
    );
    return tvShow;
  }

  @override
  Future<List<TvShow>> searchtvshow(String query) async {
    if (query.isEmpty) return [];
    final response = await dio.get(
      "/search/tv",
      queryParameters: {
        'query': query,
        'api_key': Environment.movieDbKey,
        'language': "en",
      },
    );
    return _jsonToTvShows(response.data);
  }
}
