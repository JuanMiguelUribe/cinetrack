import 'package:cinetrack/presentation/providers/providers.dart';
import 'package:cinetrack/presentation/widgets/shared/botton_nav_with_animation.dart';
import 'package:cinetrack/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  static const name = "home-screen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeView(),
      bottomNavigationBar: BottonNavWithAnimation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomAppbar(),
          MoviesSlideshow(movies: slideShowMovies, showTitle: true),
          MovieHorizontalListView(
            movies: nowPlayingMovies,
            title: "En Cines",
            subtitle: DateFormat('EEEE, d MMMM', 'es').format(DateTime.now()),
            loadNextPage: () =>
                ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
          ),
          MovieHorizontalListView(
            movies: nowPlayingMovies,
            title: "Proximamente",
            subtitle: DateFormat('MMMM', 'es').format(DateTime.now()),
            loadNextPage: () =>
                ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
          ),
          MovieHorizontalListView(
            movies: nowPlayingMovies,
            title: "Populares",
            subtitle: DateFormat('MMMM', 'es').format(DateTime.now()),
            loadNextPage: () =>
                ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
          ),
          MovieHorizontalListView(
            movies: nowPlayingMovies,
            title: "Mejor Calificadas",
            subtitle: "Siempre",
            loadNextPage: () =>
                ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
          ),

          const SizedBox(height: 20), // Espacio al final de la lista
        ],
      ),
    );
  }
}
