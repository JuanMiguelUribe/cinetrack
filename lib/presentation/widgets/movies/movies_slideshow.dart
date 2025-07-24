import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cinetrack/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MoviesSlideshow extends StatelessWidget {
  final double aspectRatio;
  final double viewportFraction;
  final List<Movie> movies;
  final bool showTitle;
  const MoviesSlideshow({
    super.key,
    required this.movies,
    this.aspectRatio = 14 / 7.5,
    this.viewportFraction = 0.75,
    this.showTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Swiper(
        loop: true,
        duration: 1000,
        autoplayDelay: 8000,
        viewportFraction: viewportFraction,
        scale: 0.8,
        autoplay: true,
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 0),
          builder: DotSwiperPaginationBuilder(
            activeColor: colors.primary,
            color: colors.secondary,
          ),
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) =>
            _Slide(movie: movies[index], showTitle: showTitle),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  final bool showTitle;

  const _Slide({required this.movie, this.showTitle = true});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 9,
          offset: Offset(0, 5),
          spreadRadius: 2,
        ),
      ],
    );

    return GestureDetector(
      onTap: () {
        context.push('/movie/${movie.id}');
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30, top: 0),
        child: DecoratedBox(
          decoration: decoration,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                //* Imagen
                Positioned.fill(
                  //se llena la imagen
                  child: Image.network(
                    movie.backdropPath,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress != null) {
                        return DecoratedBox(
                          decoration: const BoxDecoration(
                            color: Colors.black12,
                          ),
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              backgroundColor: Colors.black45,
                              color: colors.onSecondary,
                            ),
                          ),
                        );
                      }
                      return FadeIn(child: child);
                    },
                  ),
                ),

                // Gradient + título solo si showTitle es true
                if (showTitle) _GradientAndTitle(movie: movie),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GradientAndTitle extends StatelessWidget {
  const _GradientAndTitle({required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black87, Colors.transparent],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: 2.0), // Baja el texto
          child: Align(
            alignment: Alignment.bottomCenter,
            // child: Text(
            //   movie.title,
            //   maxLines: 2,
            //   overflow: TextOverflow.ellipsis,
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 12,
            //     fontWeight: FontWeight.w600,
            //   ),
            // ),
          ),
        ),
      ),
    );
  }
}
