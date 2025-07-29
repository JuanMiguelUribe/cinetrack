import 'package:movieflex/infraestructure/datasources/moviedb_datasource.dart';
import 'package:movieflex/infraestructure/repositories/movie_repository_imple.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Este repositorio es inmutable
final movieRepositoryProvider = Provider((e) {
  return MovieRepositoryImple(MoviedbDatasource());
});
