import 'package:movieflex/domain/entities/actor.dart';
import 'package:movieflex/domain/respositories/actors_repository.dart';

import '../../domain/datasources/actors_datasource.dart';

class ActorRepositoryImpl extends ActorsRepository {
  final ActorsDatasource datasource;

  ActorRepositoryImpl(this.datasource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return datasource.getActorsByMovie(movieId);
  }

  @override
  Future<List<Actor>> getActorsByShow(String tvshowId) {
    return datasource.getActorsByShow(tvshowId);
  }

  @override
  Future<PersonDetailsEntity> getActorById(String id) {
    return datasource.getActorById(id);
  }

  @override
  Future<ActorCredit> getCreditByActor(String id) {
    return datasource.getCreditByActor(id);
  }
}
