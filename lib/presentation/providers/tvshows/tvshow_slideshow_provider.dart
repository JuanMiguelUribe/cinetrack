import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieflex/domain/entities/tv_shows.dart';
import 'package:movieflex/presentation/providers/providers.dart';

final tvShowSlideshowProvider = Provider<List<TvShow>>((ref) {
  final popularTvShow = ref.watch(popularTvShowProvider);

  if (popularTvShow.isEmpty) return [];
  return popularTvShow.sublist(0, 8);
});
