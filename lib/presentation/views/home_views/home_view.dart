import 'package:flutter/material.dart';
import 'package:movieflex/domain/entities/movie.dart';
import 'package:movieflex/presentation/providers/providers.dart';
import 'package:movieflex/presentation/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../l10n/app_localizations.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();

    // Cargar solo películas inicialmente
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
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

                buildSectionDivider(
                  AppLocalizations.of(context)!.movies,
                  context,
                ),
                //*Barra de busqueda
                SearchBarWidget(ref: ref),

                _MoviesSectionSlides(
                  nowPlayingMovies: nowPlayingMovies,
                  ref: ref,
                  upcomingMovies: upcomingMovies,
                  popularMovies: popularMovies,
                  topRatedMovies: topRatedMovies,
                ),

                const SizedBox(height: 100),
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
            fontSize: 30,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: colors.onSurface.withAlpha(150),
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
            title: AppLocalizations.of(context)!.nowPlaying,
            subtitle: DateFormat(
              'EEEE, d MMMM',
              Localizations.localeOf(context).languageCode,
            ).format(DateTime.now()),
            loadNextPage: () =>
                ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
          ),
          MovieHorizontalListView(
            movies: upcomingMovies,
            title: AppLocalizations.of(context)!.coomingSoon,
            subtitle: DateFormat(
              'MMMM',
              Localizations.localeOf(context).languageCode,
            ).format(DateTime.now()),
            loadNextPage: () =>
                ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
          ),
          MovieHorizontalListView(
            movies: popularMovies,
            title: AppLocalizations.of(context)!.popular,
            subtitle: DateFormat(
              'MMMM',
              Localizations.localeOf(context).languageCode,
            ).format(DateTime.now()),
            loadNextPage: () =>
                ref.read(popularMoviesProvider.notifier).loadNextPage(),
          ),
          MovieHorizontalListView(
            movies: topRatedMovies,
            title: AppLocalizations.of(context)!.topRated,
            subtitle: AppLocalizations.of(context)!.always,
            loadNextPage: () =>
                ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
          ),
        ],
      ),
    );
  }
}
