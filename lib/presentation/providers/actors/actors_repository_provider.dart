import 'package:cinetrack/infraestructure/datasources/actor_moviedb_datasource.dart';
import 'package:cinetrack/infraestructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Este repositorio es inmutable
final actorsRepositoryProvider = Provider((e) {
  return ActorRepositoryImpl(ActorMoviedbDatasource());
});
