import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieflex/infraestructure/datasources/isar_datasource.dart';
import 'package:movieflex/infraestructure/repositories/local_storage_repository_impl.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(IsarDatasource());
});

final isFavoriteProvider = FutureProvider.family
    .autoDispose<bool, ({String type, int id})>((ref, data) async {
      final repo = ref.read(localStorageRepositoryProvider);

      if (data.type == 'movie') {
        return await repo.isMovieFavorite(data.id);
      } else {
        return await repo.isTvShowFavorite(data.id);
      }
    });
