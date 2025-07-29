import 'package:animate_do/animate_do.dart';
import 'package:movieflex/domain/entities/movie_details.dart';
import 'package:movieflex/infraestructure/mappers/movie_details_to_movie_mapper.dart';
import 'package:movieflex/l10n/app_localizations.dart';
import 'package:movieflex/presentation/providers/movies/movie_details_provider.dart';
import 'package:movieflex/presentation/providers/providers.dart';
import 'package:movieflex/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class MovieScreen extends ConsumerStatefulWidget {
  final String movieId;
  static const name = "movie-screen";
  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();

    ref
        .read(movieInfoProvider.notifier)
        .loadMovie(widget.movieId); // Cargar la película al iniciar
    ref
        .read(actorsByMovieProvider.notifier)
        .loadActors(widget.movieId); // Cargar la película al iniciar
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MovieDetails? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("${AppLocalizations.of(context)!.loading} ..."),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movie),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _MovieDetails(movie: movie),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final MovieDetails movie;
  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 3),

        Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            children: movie.genres
                .map((genre) => GenreChip(label: genre, size: 1.2))
                .toList(),
          ),
        ),
        SizedBox(height: 3),

        if (movie.adult ?? false)
          Center(
            child: Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
          ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Center(
                  child: AnimatedRatingCircle(
                    rating: movie.voteAverage,
                    size: 60,
                  ),
                ),
              ),
              const SizedBox(width: 1),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, left: 8),

                  child: ExpandableText(
                    text: (movie.overview.trim().isNotEmpty)
                        ? movie.overview
                        : AppLocalizations.of(context)!.resultsSearch,

                    wordLimit: 30,
                    style: textStyles.bodyMedium?.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            AppLocalizations.of(context)!.cast,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: colors.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5),

        _ActorsByMovie(movieId: movie.id.toString()),
      ],
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final String movieId;
  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);
    if (actorsByMovie[movieId] == null) {
      return const CircularProgressIndicator(strokeWidth: 2);
    }
    final actors = actorsByMovie[movieId]!;

    return SizedBox(
      height: 300,

      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          final actor = actors[index];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      actor.profilePath ?? '',
                      height: 150,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: 100,
                  child: Text(
                    actor.name,
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 0),
                SizedBox(
                  width: 100,
                  child: Text(
                    actor.character ?? 'Not Found',
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CustomSliverAppBar extends ConsumerWidget {
  final MovieDetails movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavoriteFuture = ref.watch(
      isFavoriteProvider((type: 'movie', id: movie.id)),
    );

    final colors = Theme.of(context).colorScheme;

    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.58,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () async {
            final movie = this.movie.fromMovieDetailsToMovieEntity();
            await ref
                .read(localStorageRepositoryProvider)
                .toggleFavoriteMovie(movie);
            ref.invalidate(isFavoriteProvider((type: 'movie', id: movie.id)));
          },
          icon: isFavoriteFuture.when(
            loading: () => CircularProgressIndicator(strokeWidth: 2),
            data: (isFavorite) => isFavorite
                ? Icon(Icons.favorite_rounded, color: Colors.red)
                : const Icon(Icons.favorite_border_rounded),
            error: (_, _) => throw UnimplementedError(),
          ),
        ),
      ],
      leading: LeadingRoundedIconButton(
        iconSize: 18,
        paddingSize: 12,
        icon: Icons.close,
        onPressed: () => Navigator.pop(context),
      ),

      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        titlePadding: const EdgeInsets.symmetric(vertical: 2),
        centerTitle: true,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              movie.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: colors.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 12),
                  children: [
                    TextSpan(
                      text:
                          "${movie.releaseDate != null ? DateFormat('d MMMM y').format(movie.releaseDate!) : AppLocalizations.of(context)!.unknownDate} •",
                      style: TextStyle(color: colors.onSurface),
                    ),
                    TextSpan(
                      text:
                          " ${movie.runtime! ~/ 60}h ${movie.runtime! % 60}min ",
                      style: TextStyle(
                        color: colors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        background: _BackgroundStack(movie: movie),
      ),
    );
  }
}

class _BackgroundStack extends StatelessWidget {
  final MovieDetails movie;
  const _BackgroundStack({required this.movie});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final gradientColors = isDarkMode
        ? [Colors.transparent, colors.surface.withOpacity(0.91), colors.surface]
        : [Colors.transparent, colors.surface.withOpacity(0.5), colors.surface];
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.network(
            movie.posterPath!,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null)
                return const Center(child: CircularProgressIndicator());

              return FadeIn(child: child);
            },
          ),
        ),

        _CustomGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.7, 0.85, 1.0],
          colors: gradientColors,
        ),

        _CustomGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,

          stops: const [0.0, 0.2],
          colors: [Colors.black45, Colors.transparent],
        ),
      ],
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;
  const _CustomGradient({
    required this.begin,
    required this.end,
    required this.stops,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,

            stops: stops,
            colors: colors,
          ),
        ),
      ),
    );
  }
}
