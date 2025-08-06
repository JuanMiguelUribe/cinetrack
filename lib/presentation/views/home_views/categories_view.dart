import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieflex/presentation/providers/movies/movies_providers.dart';
import 'package:movieflex/presentation/widgets/movies/movie_horizontal_listview.dart';

class DiscoverView extends ConsumerWidget {
  const DiscoverView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final discoverMovies = ref.watch(discoverMoviesProvider);
    return Scaffold(body: MovieHorizontalListView(movies: discoverMovies));
  }
}
