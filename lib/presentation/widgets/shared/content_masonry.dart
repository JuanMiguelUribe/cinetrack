import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movieflex/domain/entities/movie.dart';
import 'package:movieflex/presentation/widgets/widgets.dart';

class MasonrySection extends StatelessWidget {
  final String title;
  final List<Movie> movies;
  final int itemsToShow;
  final bool showSeeMore;
  final VoidCallback onSeeMore;
  final bool showSeeLess;
  final VoidCallback? onSeeLess;

  MasonrySection({
    super.key,
    required this.title,
    required this.movies,
    required this.itemsToShow,
    required this.showSeeMore,
    required this.onSeeMore,
    this.showSeeLess = false,
    this.onSeeLess,
  });

  @override
  Widget build(BuildContext context) {
    final displayedMovies = movies
        .take(itemsToShow)
        .toList(); // Solo muestra los items necesarios

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 15),

          MasonryGridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 20,
            itemCount: displayedMovies.length,
            itemBuilder: (context, index) {
              return ContentPosterLink(movie: displayedMovies[index]);
            },
          ),

          const SizedBox(height: 20),

          if (showSeeMore)
            Center(
              child: ElevatedButton(
                onPressed: onSeeMore,
                child: const Text("Ver más"),
              ),
            )
          else if (showSeeLess && onSeeLess != null)
            Center(
              child: TextButton(
                onPressed: onSeeLess,
                child: const Text("Ver menos"),
              ),
            ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
