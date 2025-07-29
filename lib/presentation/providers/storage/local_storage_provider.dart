import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieflex/infraestructure/datasources/isar_datasource.dart';
import 'package:movieflex/infraestructure/repositories/local_storage_repository_impl.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(IsarDatasource());
});
