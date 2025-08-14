import 'package:movieflex/infraestructure/datasources/tvshows_datasource.dart';
import 'package:movieflex/infraestructure/repositories/tvshows_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieflex/presentation/providers/providers.dart';

//Este repositorio es inmutable
final tvshowsRepositoryProvider = Provider<TvshowsDbRepositoryImpl>((ref) {
  // final lang = ref.watch(languageProvider);
  final language = ref.watch(languageProvider);

  return TvshowsDbRepositoryImpl(TvshowsDBDatasource(language: language));
});
