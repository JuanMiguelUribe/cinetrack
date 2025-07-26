import 'package:cinetrack/infraestructure/datasources/tvshows_datasource.dart';
import 'package:cinetrack/infraestructure/repositories/tvshows_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Este repositorio es inmutable
final tvshowsRepositoryProvider = Provider((e) {
  return TvshowsDbRepositoryImpl(TvshowsDBDatasource());
});
