import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movieflex/domain/entities/movie.dart';

class ContentPosterLink extends StatelessWidget {
  final Movie movie;
  const ContentPosterLink({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => context.push('/movie/${movie.id}'),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(15),
        child: FadeIn(
          child: Container(
            decoration: BoxDecoration(
              color: colors.onSurface.withOpacity(0.2),
              // border: BoxBorder.symmetric(),
            ),
            child: Stack(
              children: [
                Image.network(
                  movie.posterPath!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: _GradientAndTitle(movie: movie),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GradientAndTitle extends StatelessWidget {
  final Movie movie;
  const _GradientAndTitle({required this.movie});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      height: 60, // <-- altura fija o adaptable según lo que necesites
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.black87, Colors.transparent],
        ),
      ),
      alignment: Alignment.bottomRight,
      child: Text(
        movie.title,
        style: TextStyle(color: colors.surface, fontWeight: FontWeight.w500),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
