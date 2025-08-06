import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

class _PageSwiper extends StatefulWidget {
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
  State<_PageSwiper> createState() => _PageSwiperState();
}

class _PageSwiperState extends State<_PageSwiper> {
  final PageController pageController = PageController();
  final PageController dotController = PageController(viewportFraction: 1 / 5);
  int _currentPage = 10;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      dotController.jumpTo(pageController.offset);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.pageController.hasClients &&
          widget.discoverMovies.length > 10) {
        widget.pageController.jumpToPage(10);
      }
    });

    widget.pageController.addListener(() {
      final page = widget.pageController.page?.round() ?? 10;
      if (page != _currentPage) {
        setState(() {
          _currentPage = page;
        });
      }

      pageController.addListener(() {
        final page = pageController.page?.round() ?? 0;
        if (page != _currentPage) {
          setState(() {
            _currentPage = page;
          });
        }

        dotController.jumpTo(pageController.offset);
      });
      if (widget.loadNextPage == null) return;
      if (page >= widget.discoverMovies.length - 1) {
        widget.loadNextPage!(); // Llama al método para traer más películas
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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

              return AnimatedBuilder(
                animation: widget.pageController,
                builder: (context, child) {
                  double value = 1.0;
                  if (widget.pageController.position.haveDimensions) {
                    value = widget.pageController.page! - index;
                    value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
                  }

                  return Center(
                    child: SizedBox(
                      height: Curves.easeOut.transform(value) * 520,
                      width: 320,
                      child: child,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Container(
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
                        margin: const EdgeInsets.symmetric(vertical: 20),
                      ),
                      Positioned(
                        left: 20,
                        bottom: 60,
                        right: 20,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "⭐ ${movie.popularity.toStringAsFixed(1)}",
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 40,
          child: PageView.builder(
            controller: dotController,
            itemCount: widget.discoverMovies.length,
            physics:
                const NeverScrollableScrollPhysics(), // que no se pueda arrastrar
            itemBuilder: (context, index) {
              final isSelected =
                  index ==
                  _currentPage; // asume que actualizas esto desde el otro PageView

              return Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: isSelected ? 20 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.red : Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            },
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
