import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieflex/domain/entities/seasons.dart';
import 'package:movieflex/presentation/providers/providers.dart';

/// Tipo de callback que usará el notifier
final tvShowSeasonsProvider =
    FutureProvider.family<List<Season>, Map<String, dynamic>>((ref, params) {
      final repository = ref.watch(tvshowsRepositoryProvider);

      final id = params['id'] as String;
      final season = params['season'] as int;

      return repository.tvShowSeasons(id, season);
    });
