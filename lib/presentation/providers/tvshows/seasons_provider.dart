import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieflex/domain/entities/seasons.dart';
import 'package:movieflex/presentation/providers/providers.dart';

/// Tipo de callback que usará el notifier
final tvShowSeasonsProvider = FutureProvider.family<Season, (String, int)>((
  ref,
  params,
) {
  final repository = ref.watch(tvshowsRepositoryProvider);

  final id = params.$1;
  final season = params.$2; //

  return repository.tvShowSeasons(id, season);
});

final selectedSeasonProvider = StateProvider.autoDispose<int>((ref) => 1);
