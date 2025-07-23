import 'package:cinetrack/domain/entities/movie.dart';
import 'package:cinetrack/domain/entities/tv_shows.dart';
import 'package:cinetrack/presentation/providers/providers.dart';
import 'package:cinetrack/presentation/widgets/shared/botton_nav_with_animation.dart';
import 'package:cinetrack/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  static const name = "home-screen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
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
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(airingTvShowProvider.notifier).loadNextPage();
    ref.read(onTheAirTvShowProvider.notifier).loadNextPage();
    ref.read(popularTvShowProvider.notifier).loadNextPage();
    ref.read(topRatedTvShowProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(initialLoadingProvider);
    if (isLoading) return const FullScreenLoader();

    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final airingTvShows = ref.watch(airingTvShowProvider);
    final onTheAirTvShows = ref.watch(onTheAirTvShowProvider);
    final popularTvShows = ref.watch(popularTvShowProvider);
    final topRatedTvShows = ref.watch(topRatedTvShowProvider);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          snap: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(
              top: kToolbarHeight * 0.1,
            ), // opcional
            child: CustomAppbar(),
          ),
          expandedHeight: 80,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                // CustomAppbar(),
                MoviesSlideshow(movies: slideShowMovies, showTitle: true),

                buildSectionDivider("Películas", context),

                _MoviesSectionSlides(
                  nowPlayingMovies: nowPlayingMovies,
                  ref: ref,
                  upcomingMovies: upcomingMovies,
                  popularMovies: popularMovies,
                  topRatedMovies: topRatedMovies,
                ),

                buildSectionDivider("Series", context),

                // const SizedBox(height: 150),
                _SeriesSectionSlides(
                  airingTvShows: airingTvShows,
                  ref: ref,
                  onTheAirTvShows: onTheAirTvShows,
                  popularTvShows: popularTvShows,
                  topRatedTvShows: topRatedTvShows,
                ), // Espacio al final de la lista
              ],
            );
          }, childCount: 1),
        ),
      ],
    );
  }
}

Widget buildSectionDivider(String title, BuildContext context) {
  final colors = Theme.of(context).colorScheme;

  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Row(
      children: [
        const SizedBox(width: 10),
        Expanded(
          child: Divider(
            color: colors.outlineVariant.withOpacity(0.8),
            thickness: 1,
            endIndent: 10,
          ),
        ),
        Text(
          title,
          style: GoogleFonts.robotoFlex(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: colors.onSurface.withOpacity(0.3),
          ),
        ),

        Expanded(
          child: Divider(
            color: colors.outlineVariant.withOpacity(0.8),
            thickness: 1,
            indent: 10,
          ),
        ),
        const SizedBox(width: 10),
      ],
    ),
  );
}

class _MoviesSectionSlides extends StatelessWidget {
  const _MoviesSectionSlides({
    required this.nowPlayingMovies,
    required this.ref,
    required this.upcomingMovies,
    required this.popularMovies,
    required this.topRatedMovies,
  });

  final List<Movie> nowPlayingMovies;
  final WidgetRef ref;
  final List<Movie> upcomingMovies;
  final List<Movie> popularMovies;
  final List<Movie> topRatedMovies;

  @override
  Widget build(BuildContext context) {
    // final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        children: [
          MovieHorizontalListView(
            movies: nowPlayingMovies,
            title: "En Cines",
            subtitle: DateFormat('EEEE, d MMMM', 'es').format(DateTime.now()),
            loadNextPage: () =>
                ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
          ),
          MovieHorizontalListView(
            movies: upcomingMovies,
            title: "Proximamente",
            subtitle: DateFormat('MMMM', 'es').format(DateTime.now()),
            loadNextPage: () =>
                ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
          ),
          MovieHorizontalListView(
            movies: popularMovies,
            title: "Populares",
            subtitle: DateFormat('MMMM', 'es').format(DateTime.now()),
            loadNextPage: () =>
                ref.read(popularMoviesProvider.notifier).loadNextPage(),
          ),
          MovieHorizontalListView(
            movies: topRatedMovies,
            title: "Mejor Calificadas",
            subtitle: "Siempre",
            loadNextPage: () =>
                ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
          ),
        ],
      ),
    );
  }
}

class _SeriesSectionSlides extends StatelessWidget {
  const _SeriesSectionSlides({
    required this.airingTvShows,
    required this.ref,
    required this.onTheAirTvShows,
    required this.popularTvShows,
    required this.topRatedTvShows,
  });

  final List<TvShow> airingTvShows;
  final WidgetRef ref;
  final List<TvShow> onTheAirTvShows;
  final List<TvShow> popularTvShows;
  final List<TvShow> topRatedTvShows;

  @override
  Widget build(BuildContext context) {
    // final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(
        children: [
          TvShowHorizontalListView(
            tvShows: airingTvShows,
            title: "Al Aire Hoy",
            subtitle: DateFormat('EEEE, d MMMM', 'es').format(DateTime.now()),
            loadNextPage: () =>
                ref.read(airingTvShowProvider.notifier).loadNextPage(),
          ),
          TvShowHorizontalListView(
            tvShows: onTheAirTvShows,
            title: "Esta semana",
            subtitle: DateFormat('M MMMM', 'es').format(DateTime.now()),
            loadNextPage: () =>
                ref.read(onTheAirTvShowProvider.notifier).loadNextPage(),
          ),
          TvShowHorizontalListView(
            tvShows: popularTvShows,
            title: "Populares",
            subtitle: DateFormat('MMMM', 'es').format(DateTime.now()),
            loadNextPage: () =>
                ref.read(popularTvShowProvider.notifier).loadNextPage(),
          ),
          TvShowHorizontalListView(
            tvShows: topRatedTvShows,
            title: "Mejor Calificadas",
            subtitle: "Siempre",
            loadNextPage: () =>
                ref.read(topRatedTvShowProvider.notifier).loadNextPage(),
          ),
        ],
      ),
    );
  }
}
