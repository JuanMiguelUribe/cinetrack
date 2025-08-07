import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieflex/config/helpers/human_formats.dart';
import 'package:movieflex/config/helpers/localizations_helper.dart';
import 'package:movieflex/config/theme/app_text_styles.dart';
import 'package:movieflex/domain/entities/movie.dart';
import 'package:movieflex/domain/entities/movie_details.dart';
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
        child: SingleChildScrollView(
          physics:
              const AlwaysScrollableScrollPhysics(), // Para permitir el pull even sin overflow
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //   child: Align(
              //     alignment: Alignment.centerLeft,
              //     child: Text(
              //       'Discover Movies',
              //       style: Theme.of(context).textTheme.headlineMedium,
              //     ),
              //   ),
              // ),
              const SizedBox(height: 40),
              _PageSwiper(
                key: ValueKey(_pageController),
                size: size,
                pageController: _pageController,
                discoverMovies: discoverMovies,
                loadNextPage: () => ref
                    .read(discoverMoviesProvider.notifier)
                    .loadNextRandomPageAdded(),
                loadNextPageBackward: () => ref
                    .read(discoverMoviesProvider.notifier)
                    .loadPreviousRandomPageAdded(),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class _PageSwiper extends StatefulWidget {
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
  State<_PageSwiper> createState() => _PageSwiperState();
}

class _PageSwiperState extends State<_PageSwiper> {
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
        // Desplazamos el scroll para seguir en la misma película
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
          height: widget.size.width * 1.3,
          child: PageView.builder(
            controller: widget.pageController,
            itemCount: widget.discoverMovies.length,
            physics: RangeMaintainingScrollPhysics(),
            padEnds: true,
            itemBuilder: (context, index) {
              final movie = widget.discoverMovies[index];
              final loc = AppLocalizations.of(context)!;

              return Column(
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
                    child: Container(
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
                  ),
                  const SizedBox(height: 12),
                  movie.genreIds.isNotEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //*Generos
                            const SizedBox(width: 8),
                            Center(
                              child: Wrap(
                                spacing: 8,
                                children: movie.genreIds.take(2).map((genre) {
                                  final key = genreTranslationKeys[genre];
                                  final translated = key != null
                                      ? loc.getTranslation(key)
                                      : genre;

                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: colors.onSurface.withAlpha(220),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      translated,
                                      style: TextStyle(
                                        color: colors.surface,
                                        fontSize: 14,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),

                            //*RATING
                            SizedBox(
                              width: 60,
                              child: Row(
                                children: [
                                  AnimatedRatingCircle(
                                    rating: movie.voteAverage,
                                    size: 26,
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ],
                        )
                      : SizedBox(
                          width: 60,
                          child: Row(
                            children: [
                              Icon(
                                Icons.star_half_outlined,
                                color: Colors.yellow.shade800,
                                size: 28,
                              ),
                              Text(
                                movie.voteAverage.toStringAsFixed(1),
                                style: textStyles.bodyMedium?.copyWith(
                                  color: Colors.yellow.shade800,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                  Text(
                    movie.title,
                    style: AppTextStyles.styleForTitleContentDiscover(context),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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

// MovieDetails mapMovieToDetails(Movie movie) {
//   final genreNames = movie.genreIds
//       .map((id) => genreMap[int.tryParse(id.toString())])
//       .whereType<String>() // esto filtra los nulos
//       .toList();

//   return MovieDetails(
//     id: movie.id,
//     title: movie.title,
//     posterPath: movie.posterPath ?? '',
//     overview: movie.overview,
//     popularity: movie.voteAverage,
//     originalTitle: movie.originalTitle,
//     backdropPath: '',
//     releaseDate: null,
//     runtime: null,
//     voteAverage: movie.voteAverage,
//     voteCount: movie.voteCount,
//     originalLanguage: '',
//     originCountry: [],
//     genres: genreNames, // <--- ahora pasas List<String>
//     homepage: '',
//     budget: 0,
//     revenue: 0,
//     video: null,
//     status: '',
//     imdbId: '',
//     belongsToCollection: null,
//     productionCompanies: [],
//     productionCountries: [],
//     spokenLanguages: [],
//   );
// }

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
