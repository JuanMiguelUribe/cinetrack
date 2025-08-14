import 'package:movieflex/infraestructure/datasources/actor_moviedb_datasource.dart';
import 'package:movieflex/infraestructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieflex/presentation/providers/providers.dart';

//Este repositorio es inmutable
final actorsRepositoryProvider = Provider<ActorRepositoryImpl>((ref) {
  final language = ref.watch(languageProvider);

  return ActorRepositoryImpl(ActorMoviedbDatasource(language: language));
});
