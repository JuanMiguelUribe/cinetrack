import 'dart:math';

import 'package:movieflex/domain/datasources/tvshows_datasources.dart';
import 'package:movieflex/domain/entities/seasons.dart';
import 'package:movieflex/domain/entities/tv_show_details.dart';
import 'package:movieflex/domain/entities/tv_shows.dart';
import 'package:movieflex/infraestructure/models/movieDb/seasons_response.dart';

import 'package:movieflex/infraestructure/models/movieDb/tvshow_details_response.dart'
    hide Season;
import 'package:movieflex/infraestructure/models/movieDb/tvshowdb_response.dart';
import 'package:dio/dio.dart';
import 'package:movieflex/config/constants/environment.dart';
import '../mappers/tvshow_mapper.dart';

class TvshowsDBDatasource extends TvShowsDBDatasource {
  final String language;

  TvshowsDBDatasource({this.language = "en"});

  late final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.movieDbKey,
        'language': language,
      },
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
      queryParameters: {'page': page, "language": language},
    );

    return _jsonToTvShows(response.data);
  }

  @override
  Future<List<TvShow>> getTvShowsOnTheAir({int page = 1}) async {
    final response = await dio.get(
      "/tv/on_the_air",
      queryParameters: {'page': page, "language": language},
    );
    return _jsonToTvShows(response.data);
  }

  @override
  Future<List<TvShow>> getTvShowsPopular({int page = 1}) async {
    final response = await dio.get(
      "/tv/popular",
      queryParameters: {'page': page, "language": language},
    );
    return _jsonToTvShows(response.data);
  }

  @override
  Future<List<TvShow>> getTvShowsTopRated({int page = 1}) async {
    final response = await dio.get(
      "/tv/top_rated",
      queryParameters: {'page': page, "language": language},
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
        "language": language,
      },
    );
    return _jsonToTvShows(response.data);
  }

  @override
  Future<List<TvShow>> getRecomendationsTvShowById(
    String tvshowId, {
    int page = 1,
  }) async {
    final response = await dio.get(
      '/tv/$tvshowId/recommendations',
      queryParameters: {'page': page, "language": language},
    );

    return _jsonToTvShows(response.data);
  }

  @override
  Future<List<TvShow>> discoverSeries({int? page}) async {
    final int randomPage = Random().nextInt(498) + 1;

    final response = await dio.get(
      "/discover/tv",
      queryParameters: {
        'page': randomPage,
        "language": language,
        // "sort_by": "primary_release_date.asc",
      },
    );
    return _jsonToTvShows(response.data);
  }

  @override
  Future<Season> tvShowSeasons(String id, int season) async {
    try {
      final response = await dio.get("/tv/$id/season/$season");

      if (response.statusCode != 200) {
        // Aquí ya evitas que se muestre un 404 feo
        throw Failure(message: "No pudimos encontrar esa temporada.");
      }

      final tvshowDetails = SeasonsDbResponde.fromJson(response.data);
      final seasonTv = TvshowMapper.seasonsDbToEntity(tvshowDetails);

      return seasonTv;
    } on DioException catch (_) {
      // Errores de red, conexión, timeout, etc.
      throw Failure(message: "Connection error. Please try again.");
    } catch (e) {
      // Cualquier otro error inesperado
      throw Failure(message: "An unexpected error occurred.");
    }
  }
}

class Failure implements Exception {
  final String message;
  Failure({required this.message});
}
