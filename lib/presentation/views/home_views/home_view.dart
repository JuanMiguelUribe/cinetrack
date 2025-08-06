import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieflex/domain/entities/movie.dart';
import 'package:movieflex/domain/entities/tv_shows.dart';
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
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    // Cargar solo películas inicialmente
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(airingTvShowProvider.notifier).loadNextPage();
      ref.read(onTheAirTvShowProvider.notifier).loadNextPage();
      ref.read(popularTvShowProvider.notifier).loadNextPage();
      ref.read(topRatedTvShowProvider.notifier).loadNextPage();
    });
  }

  // @override
  // void dispose() {
  //   _pageController.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(initialLoadingProvider);
    if (isLoading) return const FullScreenLoader();

    return Scaffold(
      // drawer: AppDrawer(),
      body: Builder(
        builder: (context) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                floating: true,
                snap: true,
                pinned: false,
                elevation: 0,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                expandedHeight: 70,
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      SizedBox(height: kToolbarHeight * 0.1),
                      CustomAppbar(),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: false,
                delegate: _SegmentedControlHeader(
                  selectedIndex: selectedIndex,
                  onValueChanged: (newIndex) {
                    setState(() => selectedIndex = newIndex);
                  },
                ),
              ),

              SliverToBoxAdapter(
                child: selectedIndex == 0
                    ? const _FilmsView()
                    : const _SeriesView(),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SegmentedControlHeader extends SliverPersistentHeaderDelegate {
  final int selectedIndex;
  final ValueChanged<int> onValueChanged;

  _SegmentedControlHeader({
    required this.selectedIndex,
    required this.onValueChanged,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      alignment: Alignment.center,
      child: CupertinoSegmentedControl<int>(
        borderColor: Colors.transparent,
        selectedColor: Colors.transparent,
        pressedColor: Colors.transparent,
        unselectedColor: Colors.transparent,
        groupValue: selectedIndex,
        onValueChanged: onValueChanged,
        children: {
          0: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.movies,
                  style: TextStyle(
                    color: selectedIndex == 0
                        ? colors.primary
                        : colors.onSurface,
                    fontSize: 16,
                    fontWeight: selectedIndex == 0
                        ? FontWeight.w900
                        : FontWeight.normal,
                  ),
                ),
                Container(
                  height: 1,

                  decoration: BoxDecoration(
                    color: selectedIndex == 0
                        ? colors.primary
                        : Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
          1: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.seriesNav,
                  style: TextStyle(
                    color: selectedIndex == 1
                        ? colors.primary
                        : colors.onSurface,
                    fontSize: 16,
                    fontWeight: selectedIndex == 1
                        ? FontWeight.w900
                        : FontWeight.normal,
                  ),
                ),
                Container(
                  height: 1,

                  decoration: BoxDecoration(
                    color: selectedIndex != 0
                        ? colors.primary
                        : Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
        },
      ),
    );
  }

  @override
  double get maxExtent => 56;

  @override
  double get minExtent => 56;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

class _FilmsView extends ConsumerWidget {
  const _FilmsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    return Column(
      children: [
        const SizedBox(height: 8),
        MoviesSlideshow(movies: slideShowMovies, showTitle: true),
        buildSectionDivider(AppLocalizations.of(context)!.movies, context),
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
  }
}

class _SeriesView extends ConsumerWidget {
  const _SeriesView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final slideShowTvshows = ref.watch(tvShowSlideshowProvider);
    final airingTvShows = ref.watch(airingTvShowProvider);
    final onTheAirTvShows = ref.watch(onTheAirTvShowProvider);
    final popularTvShows = ref.watch(popularTvShowProvider);
    final topRatedTvShows = ref.watch(topRatedTvShowProvider);
    final tvItems = slideShowTvshows
        .map(
          (tv) => Movie(
            id: tv.id,
            title: tv.name,
            posterPath: tv.posterPath!,
            backdropPath: tv.backdropPath,
            overview: tv.overview ?? "",
            popularity: tv.voteAverage,
            adult: false,
            genreIds: tv.genreIds,
            originalLanguage: tv.originalLanguage ?? "",
            originalTitle: tv.originalLanguage ?? "",
            video: false,
            voteAverage: tv.voteAverage,
            voteCount: tv.voteCount,
          ),
        )
        .toList();
    return Column(
      children: [
        const SizedBox(height: 8),
        MoviesSlideshow(
          movies: tvItems,
          showTitle: true,
          aspectRatio: 14 / 7.5,
          viewportFraction: 0.80,
        ),
        buildSectionDivider(AppLocalizations.of(context)!.tvshows, context),
        //*Barra de busqueda
        SearchBarWidget(ref: ref),

        // const SizedBox(height: 150),
        _SeriesSectionSlides(
          airingTvShows: airingTvShows,
          ref: ref,
          onTheAirTvShows: onTheAirTvShows,
          popularTvShows: popularTvShows,
          topRatedTvShows: topRatedTvShows,
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
            title: AppLocalizations.of(context)!.airingToday,
            subtitle: DateFormat(
              'EEEE, d MMMM',
              Localizations.localeOf(context).languageCode,
            ).format(DateTime.now()),
            loadNextPage: () =>
                ref.read(airingTvShowProvider.notifier).loadNextPage(),
          ),
          TvShowHorizontalListView(
            tvShows: onTheAirTvShows,
            title: AppLocalizations.of(context)!.onTheAir,
            subtitle: DateFormat.EEEE(
              Localizations.localeOf(context).languageCode,
            ).format(DateTime.now()),
            loadNextPage: () =>
                ref.read(onTheAirTvShowProvider.notifier).loadNextPage(),
          ),
          TvShowHorizontalListView(
            tvShows: popularTvShows,
            title: AppLocalizations.of(context)!.popular,
            subtitle: DateFormat(
              'MMMM',
              Localizations.localeOf(context).languageCode,
            ).format(DateTime.now()),
            loadNextPage: () =>
                ref.read(popularTvShowProvider.notifier).loadNextPage(),
          ),
          TvShowHorizontalListView(
            tvShows: topRatedTvShows,
            title: AppLocalizations.of(context)!.topRated,
            subtitle: AppLocalizations.of(context)!.always,
            loadNextPage: () =>
                ref.read(topRatedTvShowProvider.notifier).loadNextPage(),
          ),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}
