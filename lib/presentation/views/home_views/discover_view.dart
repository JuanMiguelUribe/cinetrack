import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieflex/config/theme/app_text_styles.dart';
import 'package:movieflex/domain/entities/movie.dart';
import 'package:movieflex/presentation/providers/providers.dart';
import 'package:movieflex/presentation/widgets/movies/movie_horizontal_listview.dart';
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
              ),
              const SizedBox(height: 30),
            ],
          ),
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
  });

  final Size size;
  final PageController pageController;
  final List<Movie> discoverMovies;
  final VoidCallback? loadNextPage;
  @override
  _PageSwiperState createState() => _PageSwiperState();
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
      if (page < 1) {
        final previousItemCount = 20; // o la cantidad que vayas a insertar
        final viewportFraction = widget.pageController.viewportFraction;
        final pageWidth =
            widget.pageController.position.viewportDimension * viewportFraction;
        final offsetBefore = widget.pageController.offset;

        ref.read(discoverMoviesProvider.notifier).loadPreviousRandomPageAdded();

        // Desplazamos el scroll para seguir en la misma película
        final offsetAfter = offsetBefore + (pageWidth * previousItemCount);

        WidgetsBinding.instance.addPostFrameCallback((_) {
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
                          height: Curves.easeOut.transform(value) * 460,
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
                  const SizedBox(height: 8),
                  Text(
                    movie.title,
                    style: AppTextStyles.styleForTitleContentDiscover(context),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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

        // _PageIndicator(
        //   currentIndex: _currentPage - widget.pageController.initialPage,
        //   itemCount: widget.discoverMovies.length,
        // ),
      ],
    );
  }
}

// class _PageIndicator extends StatelessWidget {
//   const _PageIndicator({required this.itemCount, required this.currentIndex});

//   final int itemCount;
//   final int currentIndex;

//   @override
//   Widget build(BuildContext context) {
//     final colors = Theme.of(context).colorScheme;
//     const visibleDots = 5;
//     final middleIndex = visibleDots ~/ 2;

//     List<Widget> dots = [];

//     for (int i = 0; i < visibleDots; i++) {
//       int relativeIndex = currentIndex - middleIndex + i;

//       // Controlar bordes
//       if (currentIndex < middleIndex) {
//         relativeIndex = i; // estamos al inicio
//       } else if (currentIndex > itemCount - middleIndex - 1) {
//         relativeIndex = itemCount - visibleDots + i; // estamos al final
//       }

//       // Solo dibujar si el índice existe
//       if (relativeIndex < 0 || relativeIndex >= itemCount) {
//         dots.add(const SizedBox(width: 12)); // espacio vacío
//       } else {
//         final isActive = relativeIndex == currentIndex;

//         dots.add(
//           AnimatedContainer(
//             duration: const Duration(milliseconds: 300),
//             margin: const EdgeInsets.symmetric(horizontal: 4),
//             height: 8,
//             width: isActive ? 20 : 8,
//             decoration: BoxDecoration(
//               color: isActive ? colors.primary : colors.secondary,
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//         );
//       }
//     }

//     return Row(mainAxisAlignment: MainAxisAlignment.center, children: dots);
//   }
// }
