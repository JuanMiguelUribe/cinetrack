import 'package:movieflex/infraestructure/datasources/moviedb_datasource.dart';
import 'package:movieflex/infraestructure/repositories/movie_repository_imple.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieflex/presentation/providers/providers.dart';

//Este repositorio es inmutable
final movieRepositoryProvider = Provider<MovieRepositoryImple>((ref) {
  final language = ref.watch(languageProvider);
  return MovieRepositoryImple(MoviedbDatasource(language: language));
});
