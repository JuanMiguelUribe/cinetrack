import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:movieflex/config/helpers/localizations_helper.dart';
import 'package:movieflex/config/theme/app_text_styles.dart';
import 'package:movieflex/domain/entities/movie.dart';
import 'package:movieflex/domain/entities/tv_shows.dart';
import 'package:movieflex/l10n/app_localizations.dart';
import 'package:movieflex/presentation/providers/providers.dart';
import 'package:movieflex/presentation/widgets/widgets.dart';
import 'package:popover/popover.dart';

class DiscoverMoviesView extends ConsumerStatefulWidget {
  const DiscoverMoviesView({super.key});

  @override
  DiscoverMoviesViewState createState() => DiscoverMoviesViewState();
}

class DiscoverMoviesViewState extends ConsumerState<DiscoverMoviesView> {
  PageController _moviesPageController = PageController(
    viewportFraction: 0.8,
    initialPage: 10,
  );
  PageController _seriesPageController = PageController(
    viewportFraction: 0.8,
    initialPage: 10,
  );
  int selectedIndex = 0;

  @override
  void dispose() {
    _moviesPageController.dispose();
    _seriesPageController.dispose();
    super.dispose();
  }

  void _resetPageController() {
    setState(() {
      _moviesPageController.dispose();
      _seriesPageController.dispose();

      _moviesPageController = PageController(
        viewportFraction: 0.8,
        initialPage: 10,
      );
      _seriesPageController = PageController(
        viewportFraction: 0.8,
        initialPage: 10,
      ); // N
    });
  }

  Future<void> onRefresh() async {
    ref.invalidate(discoverMoviesProvider);
    ref.invalidate(discoverSeriesProvider);

    _resetPageController();

    await ref.read(discoverMoviesProvider.notifier).loadNextRandomPage();
    await ref.read(discoverSeriesProvider.notifier).loadNextRandomPage();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (selectedIndex == 0) {
    //     _moviesPageController.jumpToPage(10);
    //   } else {
    //     _seriesPageController.jumpToPage(10);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    final discoverMovies = ref.watch(discoverMoviesProvider);
    final discoverSeries = ref.watch(discoverSeriesProvider);
    final size = MediaQuery.of(context).size;
    final isLoading = ref.watch(initialLoadingDiscoverProvider);
    final colors = Theme.of(context).colorScheme;

    if (isLoading) return const FullScreenLoader();

    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 15),
        actions: [
          Builder(
            builder: (context) => GestureDetector(
              onTap: () => showPopover(
                context: context,
                bodyBuilder: (context) => MenuItems(
                  refresh: () {
                    onRefresh();
                    context.pop();
                  },
                ),
                backgroundColor: colors.surfaceDim,
                width: 150,
                height: 40,
                direction: PopoverDirection.left,
              ),
              child: Icon(Icons.more_vert_sharp),
            ),
          ),

          // LeadingRoundedIconButton(
          //   icon: Icons.refresh,
          //   backgroundColor: colors.onSurface.withAlpha(50),
          // ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverPersistentHeader(
              pinned: false,
              delegate: _SegmentedControlHeaderDiscover(
                selectedIndex: selectedIndex,
                onValueChanged: (newIndex) {
                  setState(() => selectedIndex = newIndex);
                },
              ),
            ),

            if (selectedIndex == 0) ...[
              SliverToBoxAdapter(
                child: _PageSwiper(
                  type: MediaType.movie,
                  size: size,
                  pageController:
                      _moviesPageController, // controlador independiente
                  discoverMovies: discoverMovies,
                  loadNextPage: () => ref
                      .read(discoverMoviesProvider.notifier)
                      .loadNextRandomPageAdded(),
                  loadNextPageBackward: () => ref
                      .read(discoverMoviesProvider.notifier)
                      .loadPreviousRandomPageAdded(),
                ),
              ),
            ] else ...[
              SliverToBoxAdapter(
                child: _PageSwiperSeries(
                  type: MediaType.tv,
                  size: size,
                  pageController:
                      _seriesPageController, // controlador independiente
                  discoverSeries: discoverSeries,
                  loadNextPage: () => ref
                      .read(discoverSeriesProvider.notifier)
                      .loadNextRandomPageAdded(),
                  loadNextPageBackward: () => ref
                      .read(discoverSeriesProvider.notifier)
                      .loadPreviousRandomPageAdded(),
                ),
              ),
            ],

            //* Películas
            const SliverToBoxAdapter(child: SizedBox(height: 30)),

            // Series
            // SliverToBoxAdapter(
            //   child: _PageSwiper(
            //     size: size,
            //     pageController:
            //         _seriesPageController, // otro controlador distinto
            //     discoverMovies: discoverSeries,
            //     loadNextPage: () => ref
            //         .read(discoverSeriesProvider.notifier)
            //         .loadNextRandomPageAdded(),
            //     loadNextPageBackward: () => ref
            //         .read(discoverSeriesProvider.notifier)
            //         .loadPreviousRandomPageAdded(),
            //   ),
            // ),
            const SliverToBoxAdapter(child: SizedBox(height: 30)),
          ],
        ),
      ),
    );
  }
}

class _PageSwiper extends ConsumerStatefulWidget {
  const _PageSwiper({
    required this.type,
    required this.size,
    required this.pageController,
    required this.discoverMovies,
    this.loadNextPage,
    this.loadNextPageBackward,
  });

  final Size size;
  final PageController pageController;
  final List<Movie> discoverMovies;
  final VoidCallback? loadNextPage;
  final VoidCallback? loadNextPageBackward;
  final MediaType type;
  @override
  ConsumerState<_PageSwiper> createState() => _PageSwiperState();
}

class _PageSwiperState extends ConsumerState<_PageSwiper> {
  int _currentPage = 10;
  late final VoidCallback _pageListener;

  @override
  void initState() {
    super.initState();

    _pageListener = () {
      final page = widget.pageController.page?.round() ?? 10;

      if (mounted && page != _currentPage) {
        setState(() {
          _currentPage = page;
        });
      }

      // Carga hacia adelante
      if (widget.loadNextPage != null &&
          page >= widget.discoverMovies.length - 1) {
        widget.loadNextPage!();
      }

      // Carga hacia atrás
      if (page <= 0) {
        final previousItemCount = 20; // o la cantidad que vayas a insertar
        final viewportFraction = widget.pageController.viewportFraction;
        final pageWidth =
            widget.pageController.position.viewportDimension * viewportFraction;
        final offsetBefore = widget.pageController.offset;

        widget.loadNextPageBackward!();
        final offsetAfter = offsetBefore + (pageWidth * previousItemCount);

        WidgetsBinding.instance.addPostFrameCallback((_) {
          Future.delayed(Duration(seconds: 1));

          if (mounted) {
            widget.pageController.jumpTo(offsetAfter);
          }
        });
      }
    };
    widget.pageController.addListener(_pageListener);
  }

  @override
  void dispose() {
    widget.pageController.removeListener(_pageListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      children: [
        SizedBox(
          height: widget.size.width * 1.38,
          child: PageView.builder(
            controller: widget.pageController,
            itemCount: widget.discoverMovies.length,
            physics: RangeMaintainingScrollPhysics(),
            padEnds: true,
            itemBuilder: (context, index) {
              final movie = widget.discoverMovies[index];
              final loc = AppLocalizations.of(context)!;
              final isFavoriteFuture = ref.watch(
                isFavoriteProvider((type: 'movie', id: movie.id)),
              );

              return GestureDetector(
                onTap: () {
                  context.push('/movie/${movie.id}');
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedBuilder(
                      animation: widget.pageController,
                      builder: (context, child) {
                        double value = 1.0;
                        if (widget.pageController.position.haveDimensions) {
                          value = widget.pageController.page! - index;
                          value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                        }

                        return Center(
                          child: SizedBox(
                            height: Curves.easeOut.transform(value) * 410,
                            width: Curves.easeOut.transform(value) * 370,
                            child: child,
                          ),
                        );
                      },
                      //*MOTRAR POSTER MOVIE/TV
                      child: _PosterPathWidget(movie: movie),
                    ),

                    //*FAVORITOS, GENEROS Y RATING
                    const SizedBox(height: 6),
                    movie.genreIds.isNotEmpty
                        ? _FavoriteGendersAndRatingWidget(
                            ref: ref,
                            movie: movie,
                            isFavoriteFuture: isFavoriteFuture,
                            colors: colors,
                            loc: loc,
                          )
                        : _FavoriteAndRatingWidget(
                            ref: ref,
                            movie: movie,
                            isFavoriteFuture: isFavoriteFuture,
                            colors: colors,
                            onPressed: () async {
                              await
                              // ref
                              //     .read(localStorageRepositoryProvider)
                              //     .toggleFavoriteMovie(movie);
                              ref
                                  .read(favoriteMoviesProvider.notifier)
                                  .toggleFavorite(movie);
                              ref.invalidate(
                                isFavoriteProvider((
                                  type: 'movie',
                                  id: movie.id,
                                )),
                              );
                            },
                          ),
                    // SizedBox(height: 8),
                    //*TITULO DE LA PELICULA
                    Text(
                      movie.title,
                      style: AppTextStyles.styleForTitleContentDiscover(
                        context,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    //*FECHA
                    Text(
                      movie.releaseDate != null
                          ? DateFormat('d MMMM y').format(movie.releaseDate!)
                          : AppLocalizations.of(context)!.unknownDate,
                      style: textStyles.bodySmall?.copyWith(
                        color: colors.onSurface.withAlpha(150),
                      ),
                    ),
                    if (movie.adult)
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            '+18',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 0),
        SizedBox(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(20, (index) {
              final isSelected = index == (_currentPage % 20);

              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: isSelected ? 20 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: isSelected
                      ? colors.primary
                      : colors.onSurface.withAlpha(100),
                  borderRadius: BorderRadius.circular(8),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _PageSwiperSeries extends ConsumerStatefulWidget {
  const _PageSwiperSeries({
    required this.type,
    required this.size,
    required this.pageController,
    required this.discoverSeries,
    this.loadNextPage,
    this.loadNextPageBackward,
  });

  final Size size;
  final PageController pageController;
  final List<TvShow> discoverSeries;
  final VoidCallback? loadNextPage;
  final VoidCallback? loadNextPageBackward;
  final MediaType type;
  @override
  ConsumerState<_PageSwiperSeries> createState() => _PageSwiperSeriesState();
}

class _PageSwiperSeriesState extends ConsumerState<_PageSwiperSeries> {
  int _currentPage = 10;
  late final VoidCallback _pageListener;

  @override
  void initState() {
    super.initState();
    _pageListener = () {
      final page = widget.pageController.page?.round() ?? 10;

      if (mounted && page != _currentPage) {
        setState(() {
          _currentPage = page;
        });
      }

      // Carga hacia adelante
      if (widget.loadNextPage != null &&
          page >= widget.discoverSeries.length - 1) {
        widget.loadNextPage!();
      }

      // Carga hacia atrás
      if (page <= 0) {
        final previousItemCount = 20; // o la cantidad que vayas a insertar
        final viewportFraction = widget.pageController.viewportFraction;
        final pageWidth =
            widget.pageController.position.viewportDimension * viewportFraction;
        final offsetBefore = widget.pageController.offset;

        widget.loadNextPageBackward!();
        final offsetAfter = offsetBefore + (pageWidth * previousItemCount);

        WidgetsBinding.instance.addPostFrameCallback((_) {
          Future.delayed(Duration(seconds: 1));

          if (mounted) {
            widget.pageController.jumpTo(offsetAfter);
          }
        });
      }
    };
    widget.pageController.addListener(_pageListener);
  }

  @override
  void dispose() {
    widget.pageController.removeListener(_pageListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    final tvItems = widget.discoverSeries
        .map(
          (tv) => Movie(
            id: tv.id,
            title: tv.name,
            posterPath: tv.posterPath!,
            overview: tv.overview ?? "",
            popularity: tv.voteAverage,
            adult: false,
            genreIds: tv.genreIds,
            originalLanguage: tv.originalLanguage ?? "",
            originalTitle: tv.originalName ?? "",
            video: false,
            voteAverage: tv.voteAverage,
            voteCount: tv.voteCount,
          ),
        )
        .toList();

    return Column(
      children: [
        SizedBox(
          height: widget.size.width * 1.38,
          child: PageView.builder(
            controller: widget.pageController,
            itemCount: widget.discoverSeries.length,
            physics: RangeMaintainingScrollPhysics(),
            padEnds: true,
            itemBuilder: (context, index) {
              final serie = widget.discoverSeries[index];
              final movie = tvItems[index];
              final loc = AppLocalizations.of(context)!;
              final isFavoriteFuture = ref.watch(
                isFavoriteProvider((type: 'tv', id: movie.id)),
              );

              return GestureDetector(
                onTap: () {
                  context.push('/tvshow/${movie.id}');
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedBuilder(
                      animation: widget.pageController,
                      builder: (context, child) {
                        double value = 1.0;
                        if (widget.pageController.position.haveDimensions) {
                          value = widget.pageController.page! - index;
                          value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                        }

                        return Center(
                          child: SizedBox(
                            height: Curves.easeOut.transform(value) * 410,
                            width: Curves.easeOut.transform(value) * 370,
                            child: child,
                          ),
                        );
                      },
                      //*MOTRAR POSTER MOVIE/TV
                      child: _PosterPathWidget(movie: movie),
                    ),

                    //*FAVORITOS, GENEROS Y RATING
                    const SizedBox(height: 6),
                    movie.genreIds.isNotEmpty
                        ? _FavoriteGendersAndRatingWidget(
                            ref: ref,
                            movie: movie,
                            isFavoriteFuture: isFavoriteFuture,
                            colors: colors,
                            loc: loc,
                          )
                        : _FavoriteAndRatingWidget(
                            ref: ref,
                            movie: movie,
                            isFavoriteFuture: isFavoriteFuture,
                            colors: colors,
                            onPressed: () async {
                              await
                              // ref
                              //     .read(localStorageRepositoryProvider)
                              //     .toggleFavoriteMovie(movie);
                              ref
                                  .read(favoriteTvShowProvider.notifier)
                                  .toggleFavorite(serie);
                              ref.invalidate(
                                isFavoriteProvider((type: 'tv', id: movie.id)),
                              );
                            },
                          ),
                    // SizedBox(height: 8),
                    //*TITULO DE LA PELICULA
                    Text(
                      movie.title,
                      style: AppTextStyles.styleForTitleContentDiscover(
                        context,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    //*FECHA
                    Text(
                      movie.releaseDate != null
                          ? DateFormat('d MMMM y').format(movie.releaseDate!)
                          : AppLocalizations.of(context)!.unknownDate,
                      style: textStyles.bodySmall?.copyWith(
                        color: colors.onSurface.withAlpha(150),
                      ),
                    ),
                    if (movie.adult)
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            '+18',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 0),
        SizedBox(
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(20, (index) {
              final isSelected = index == (_currentPage % 20);

              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: isSelected ? 20 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: isSelected
                      ? colors.primary
                      : colors.onSurface.withAlpha(100),
                  borderRadius: BorderRadius.circular(8),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _SegmentedControlHeaderDiscover extends SliverPersistentHeaderDelegate {
  final int selectedIndex;
  final ValueChanged<int> onValueChanged;

  _SegmentedControlHeaderDiscover({
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
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
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
                    fontSize: 18,
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
                    fontSize: 18,
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

class _FavoriteAndRatingWidget extends StatelessWidget {
  const _FavoriteAndRatingWidget({
    required this.ref,
    required this.movie,
    required this.isFavoriteFuture,
    required this.colors,
    this.onPressed,
  });

  final WidgetRef ref;
  final Movie movie;
  final AsyncValue<bool> isFavoriteFuture;
  final ColorScheme colors;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Spacer(),

        IconButton(
          onPressed: onPressed,
          icon: isFavoriteFuture.when(
            loading: () => CircularProgressIndicator(strokeWidth: 2),
            data: (isFavorite) => isFavorite
                ? Icon(Icons.favorite_rounded, color: Colors.red, size: 36)
                : Icon(
                    Icons.favorite_border_rounded,
                    color: colors.onSurface,
                    size: 36,
                  ),
            error: (_, _) => throw UnimplementedError(),
          ),
        ),
        //*RATING
        SizedBox(
          width: 60,
          child: Row(
            children: [
              AnimatedRatingCircle(rating: movie.voteAverage, size: 26),
              Spacer(),
            ],
          ),
        ),
        Spacer(),
      ],
    );
  }
}

class _FavoriteGendersAndRatingWidget extends StatelessWidget {
  const _FavoriteGendersAndRatingWidget({
    required this.ref,
    required this.movie,
    required this.isFavoriteFuture,
    required this.colors,
    required this.loc,
  });

  final WidgetRef ref;
  final Movie movie;
  final AsyncValue<bool> isFavoriteFuture;
  final ColorScheme colors;
  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () async {
            await
            // ref
            //     .read(localStorageRepositoryProvider)
            //     .toggleFavoriteMovie(movie);
            ref.read(favoriteMoviesProvider.notifier).toggleFavorite(movie);
            ref.invalidate(isFavoriteProvider((type: 'movie', id: movie.id)));
          },
          icon: isFavoriteFuture.when(
            loading: () => CircularProgressIndicator(strokeWidth: 2),
            data: (isFavorite) => isFavorite
                ? Icon(Icons.favorite_rounded, color: Colors.red, size: 36)
                : Icon(
                    Icons.favorite_border_rounded,
                    color: colors.onSurface,
                    size: 36,
                  ),
            error: (_, _) => throw UnimplementedError(),
          ),
        ),

        //*Generos
        // const SizedBox(width: 8),
        Center(
          child: Wrap(
            spacing: 8,
            children: movie.genreIds.take(2).map((genre) {
              final key = genreTranslationKeys[genre];
              final translated = key != null ? loc.getTranslation(key) : genre;

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: colors.onSurface.withAlpha(220),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  translated,
                  style: TextStyle(color: colors.surface, fontSize: 14),
                ),
              );
            }).toList(),
          ),
        ),

        //*RATING
        SizedBox(
          width: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              AnimatedRatingCircle(rating: movie.voteAverage, size: 26),
              Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}

class _PosterPathWidget extends StatelessWidget {
  const _PosterPathWidget({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(230),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
            image: DecorationImage(
              image: NetworkImage(movie.posterPath!),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}

final Map<String, String> genreTranslationKeys = {
  "28": 'genre_action',
  "12": 'genre_adventure',
  "16": 'genre_animation',
  "35": 'genre_comedy',
  "80": 'genre_crime',
  "99": 'genre_documentary',
  "18": 'genre_drama',
  "10751": 'genre_family',
  "14": 'genre_fantasy',
  "36": 'genre_history',
  "27": 'genre_horror',
  "10402": 'genre_music',
  "9648": 'genre_mystery',
  "10749": 'genre_romance',
  "878": 'genre_scifi',
  "10770": 'genre_tv_movie',
  "53": 'genre_thriller',
  "10752": 'genre_war',
  "37": 'genre_western',
};
