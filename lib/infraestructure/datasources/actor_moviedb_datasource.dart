import 'package:movieflex/config/constants/environment.dart';
import 'package:movieflex/domain/datasources/actors_datasource.dart';
import 'package:movieflex/domain/entities/actor.dart';
import 'package:movieflex/infraestructure/mappers/actor_mapper.dart';
import 'package:movieflex/infraestructure/models/movieDb/actorstv_response.dart';
import 'package:dio/dio.dart';

import '../models/movieDb/credits_response.dart';

class ActorMoviedbDatasource extends ActorsDatasource {
  final String language;

  ActorMoviedbDatasource({this.language = "en"});
  late final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.movieDbKey,
        'language': language,
      },
    ),
  );
  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get("/movie/$movieId/credits");
    final castResponse = CreditsResponse.fromJson(response.data);
    List<Actor> actors = castResponse.cast
        .where((actor) => actor.profilePath != "no-poster")
        .map((actor) => ActorMapper.castToEntity(actor))
        .toList();
    return actors;
  }

  @override
  Future<List<Actor>> getActorsByShow(String tvshowId) async {
    final response = await dio.get("/tv/$tvshowId/credits");
    final castResponse = ActorsTvResponse.fromJson(response.data);
    List<Actor> actors = castResponse.cast
        .where((actor) => actor.profilePath != "no-poster")
        .map((actor) => ActorMapper.actorsTvtoEntity(actor))
        .toList();
    return actors;
  }
}
