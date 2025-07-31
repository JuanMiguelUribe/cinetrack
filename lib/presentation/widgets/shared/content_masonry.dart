import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movieflex/domain/entities/movie.dart';
import 'package:movieflex/l10n/app_localizations.dart';
import 'package:movieflex/presentation/providers/bottom_nav/bottom_nav_provider.dart';
import 'package:movieflex/presentation/widgets/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MasonrySection extends ConsumerWidget {
  final String title;
  final List<Movie> movies;
  final int itemsToShow;
  final bool showSeeMore;
  final VoidCallback onSeeMore;
  final bool showSeeLess;
  final VoidCallback? onSeeLess;
  final String type;
  final bool? isContentEmpty;

  const MasonrySection({
    super.key,
    required this.title,
    required this.movies,
    required this.itemsToShow,
    required this.showSeeMore,
    required this.onSeeMore,
    this.showSeeLess = false,
    this.onSeeLess,
    required this.type,
    this.isContentEmpty = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayedMovies = movies
        .take(itemsToShow)
        .toList(); // Solo muestra los items necesarios

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionDivider(title, context),

          isContentEmpty == true
              ? _NoFavoriteContentAdded(type: type)
              : const SizedBox(height: 15),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),

            child: MasonryGridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 20,
              itemCount: displayedMovies.length,
              itemBuilder: (context, index) {
                if (index == 1) {
                  return Column(
                    children: [
                      const SizedBox(height: 30),
                      ContentPosterLink(
                        movie: displayedMovies[index],
                        type: type,
                      ),
                    ],
                  );
                }
                return ContentPosterLink(
                  movie: displayedMovies[index],
                  type: type,
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          if (isContentEmpty!)
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ref.read(navBarIndexProvider.notifier).state = 0;
                  GoRouter.of(context).go('/');
                },
                child: Text(
                  type == 'movie'
                      ? AppLocalizations.of(context)!.exploreMoreMovies
                      : AppLocalizations.of(context)!.exploreMoreTvShows,
                ),
              ),
            )
          else if (showSeeMore)
            Center(
              child: ElevatedButton(
                onPressed: onSeeMore,
                child: Text(AppLocalizations.of(context)!.showMore),
              ),
            )
          else if (showSeeLess && onSeeLess != null)
            Center(
              child: TextButton(
                onPressed: onSeeLess,
                child: Text(
                  movies.length > 4
                      ? AppLocalizations.of(context)!.showLess
                      : "",
                ),
              ),
            ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _NoFavoriteContentAdded extends StatelessWidget {
  final String type;

  const _NoFavoriteContentAdded({required this.type});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: colors.surfaceContainer,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite_outline_sharp,
                color: colors.primary,
                size: 40,
              ),
              SizedBox(height: 5),
              Text(
                "Ohh no!!",
                style: TextStyle(
                  fontSize: 15,
                  color: colors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    type == "movie"
                        ? AppLocalizations.of(
                            context,
                          )!.favoriteMovieNotAddedMessage
                        : AppLocalizations.of(
                            context,
                          )!.favoriteTvShowNotAddedMessage,
                    style: TextStyle(fontSize: 15, color: colors.onSurface),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
