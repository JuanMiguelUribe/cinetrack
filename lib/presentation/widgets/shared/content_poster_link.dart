import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movieflex/domain/entities/movie.dart';

class ContentPosterLink extends StatelessWidget {
  final Movie movie;
  final String type;
  const ContentPosterLink({super.key, required this.movie, required this.type});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return FadeInUp(
      child: GestureDetector(
        onTap: () => context.push('/$type/${movie.id}'),
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(15),
          child: Container(
            decoration: BoxDecoration(
              color: colors.onSurface.withAlpha(80),
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
    // final colors = Theme.of(context).colorScheme;
    return Container(
      height: 60, // <-- altura fija o adaptable según lo que necesites
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
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
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
