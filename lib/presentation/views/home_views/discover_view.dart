import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:movieflex/config/helpers/localizations_helper.dart';
import 'package:movieflex/config/theme/app_text_styles.dart';
import 'package:movieflex/domain/entities/movie.dart';
import 'package:movieflex/l10n/app_localizations.dart';
import 'package:movieflex/presentation/providers/providers.dart';
import 'package:movieflex/presentation/widgets/widgets.dart';

class DiscoverMoviesView extends ConsumerStatefulWidget {
  const DiscoverMoviesView({super.key});

  @override
  DiscoverMoviesViewState createState() => DiscoverMoviesViewState();
}

class DiscoverMoviesViewState extends ConsumerState<DiscoverMoviesView> {
  PageController _pageController = PageController(
    viewportFraction: 0.8,
    initialPage: 10,
  );
  int selectedIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _resetPageController() {
    _pageController.dispose();
    _pageController = PageController(
      viewportFraction: 0.8,
      initialPage: 10,
    ); // Nueva instancia
    setState(() {});
  }

  Future<void> _onRefresh() async {
    await ref.read(discoverMoviesProvider.notifier).loadNextRandomPage();
    _resetPageController();
  }

  @override
  Widget build(BuildContext context) {
    final discoverMovies = ref.watch(discoverMoviesProvider);
    final size = MediaQuery.of(context).size;
    final isLoading = ref.watch(initialLoadingDiscoverProvider);

    if (isLoading) return const FullScreenLoader();

    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
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

            // Películas
            SliverToBoxAdapter(
              child: _PageSwiper(
                size: size,
                pageController: _pageController, // controlador independiente
                discoverMovies: discoverMovies,
                loadNextPage: () => ref
                    .read(discoverMoviesProvider.notifier)
                    .loadNextRandomPageAdded(),
                loadNextPageBackward: () => ref
                    .read(discoverMoviesProvider.notifier)
                    .loadPreviousRandomPageAdded(),
              ),
            ),

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
    super.key,
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
                    const SizedBox(height: 0),
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
                      "${movie.releaseDate != null ? DateFormat('d MMMM y').format(movie.releaseDate!) : AppLocalizations.of(context)!.unknownDate}",
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

        const SizedBox(height: 16),
        SizedBox(
          height: 40,
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

class _FavoriteAndRatingWidget extends StatelessWidget {
  const _FavoriteAndRatingWidget({
    super.key,
    required this.ref,
    required this.movie,
    required this.isFavoriteFuture,
    required this.colors,
  });

  final WidgetRef ref;
  final Movie movie;
  final AsyncValue<bool> isFavoriteFuture;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Spacer(),

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
    super.key,
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
  const _PosterPathWidget({super.key, required this.movie});

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
                color: Colors.black.withOpacity(0.3),
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
