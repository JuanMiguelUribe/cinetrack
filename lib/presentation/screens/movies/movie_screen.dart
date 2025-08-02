import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:movieflex/config/helpers/human_formats.dart';
import 'package:movieflex/config/theme/app_text_styles.dart';
import 'package:movieflex/domain/entities/movie_details.dart';
import 'package:movieflex/infraestructure/mappers/movie_details_to_movie_mapper.dart';
import 'package:movieflex/l10n/app_localizations.dart';
import 'package:movieflex/presentation/providers/movies/movie_details_provider.dart';
import 'package:movieflex/presentation/providers/providers.dart';
import 'package:movieflex/presentation/widgets/widgets.dart';
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
    final colors = Theme.of(context).colorScheme;

    if (movie == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("${AppLocalizations.of(context)!.loading} ..."),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showTrailerDialog(context, movie.id, MediaType.movie),
        icon: const Icon(Icons.play_arrow, color: Colors.white),
        label: Text(
          AppLocalizations.of(context)!.watchTrailer,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: colors.onPrimaryFixedVariant,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

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
        //*generos
        Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            children: movie.genres
                .map((genre) => GenreChip(label: genre, size: 1.2))
                .toList(),
          ),
        ),
        SizedBox(height: 3),
        //*Evaluador para peliculas +18
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

        // //*DIVISOR DE SECCIÓN,
        // _buildSectionDivider("", context),

        //*Estrella rating y el overview de la pelicula
        _RatingAndOverview(
          movie: movie,
          textStyles: textStyles,
          colors: colors,
        ),

        // SizedBox(height: 5),

        //*DIVISOR DE SECCIÓN,
        _buildSectionDivider("", context),

        //*titulo cast
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            AppLocalizations.of(context)!.cast,
            textAlign: TextAlign.center,
            style: AppTextStyles.titlesForDetailScreen(context),
          ),
        ),
        SizedBox(height: 5),

        //*Actores de la pelicula
        _ActorsByMovie(movieId: movie.id.toString()),

        //*Videos de la Pelicula
        TrailerCarousel(movieId: movie.id, type: MediaType.movie),
        // VideosFromMovie(movieId: movie.id),
        SizedBox(height: 100),
      ],
    );
  }
}

class _RatingAndOverview extends StatefulWidget {
  const _RatingAndOverview({
    required this.movie,
    required this.textStyles,
    required this.colors,
  });

  final MovieDetails movie;
  final TextTheme textStyles;
  final ColorScheme colors;

  @override
  State<_RatingAndOverview> createState() => _RatingAndOverviewState();
}

class _RatingAndOverviewState extends State<_RatingAndOverview> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Container(
            //*Decoracion Contenedor del Rating y Overview
            decoration: BoxDecoration(
              color: widget.colors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                //* ⭐ Rating Star
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      AnimatedRatingCircle(
                        rating: widget.movie.voteAverage,
                        size: 50,
                      ),
                      Text(
                        AppLocalizations.of(context)!.ratingTitle,
                        style: widget.textStyles.titleMedium?.copyWith(
                          color: widget.colors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                //* 📝 Overview text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.overviewTitle,
                        style: widget.textStyles.titleMedium?.copyWith(
                          color: widget.colors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 0),
                      ExpandableText(
                        text: (widget.movie.overview.trim().isNotEmpty)
                            ? widget.movie.overview
                            : AppLocalizations.of(context)!.resultsSearch,
                        wordLimit: 30,
                        style: widget.textStyles.bodyMedium?.copyWith(
                          color: widget.colors.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 5),

        AnimatedOpacity(
          opacity: isExpanded ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 1000),
            reverseDuration: const Duration(milliseconds: 1000),
            curve: Curves.fastLinearToSlowEaseIn,

            alignment: Alignment.topCenter,
            child: isExpanded
                ? Padding(
                    padding: const EdgeInsets.only(
                      left: 40,
                      right: 40,
                      bottom: 12,
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: widget.colors.surfaceContainerHigh,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDetailItem(
                            context,
                            AppLocalizations.of(context)!.details_title,
                            widget.movie.originalTitle,
                          ),
                          _buildDetailItem(
                            context,
                            AppLocalizations.of(context)!.details_release,
                            "${widget.movie.releaseDate != null ? DateFormat('d MMMM y').format(widget.movie.releaseDate!) : AppLocalizations.of(context)!.unknownDate}",
                          ),
                          _buildDetailItem(
                            context,
                            AppLocalizations.of(context)!.details_tagline,
                            widget.movie.tagline!,
                          ),
                          _buildDetailItem(
                            context,
                            AppLocalizations.of(context)!.details_language,
                            widget.movie.originalLanguage.toUpperCase(),
                          ),
                          _buildDetailItem(
                            context,
                            AppLocalizations.of(context)!.details_budget,
                            HumanFormats.humanExtentNumber(
                              widget.movie.budget.toDouble(),
                            ),
                          ),
                          _buildDetailItem(
                            context,
                            AppLocalizations.of(context)!.details_revenue,
                            HumanFormats.humanExtentNumber(
                              widget.movie.revenue.toDouble(),
                            ),
                          ),
                          _buildDetailItem(
                            context,
                            AppLocalizations.of(context)!.details_runtime,
                            "${widget.movie.runtime} min",
                          ),
                          _buildDetailItem(
                            context,
                            AppLocalizations.of(
                              context,
                            )!.details_production_companies,
                            widget.movie.productionCompanies.join(", "),
                          ),
                          _buildDetailItem(
                            context,
                            AppLocalizations.of(
                              context,
                            )!.details_production_countries,
                            widget.movie.productionCountries.join(", "),
                          ),
                          _buildDetailItem(
                            context,
                            AppLocalizations.of(context)!.details_language,
                            widget.movie.spokenLanguages.join(", "),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => setState(() => isExpanded = !isExpanded),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              isExpanded
                  ? AppLocalizations.of(context)!.details_hide
                  : AppLocalizations.of(context)!.show_more_details,
              style: textStyles.bodyLarge?.copyWith(
                color: colors.primary.withAlpha(170),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildDetailItem(BuildContext context, String title, String value) {
  final color = Theme.of(context).colorScheme.onSurface;
  final textStyle = Theme.of(context).textTheme.bodyMedium;

  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: RichText(
      maxLines: 2,
      text: TextSpan(
        style: textStyle?.copyWith(color: color),
        children: [
          TextSpan(
            text: "$title: ",
            style: textStyle?.copyWith(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: value),
        ],
      ),
    ),
  );
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

    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: SizedBox(
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
                      style: AppTextStyles.actorName(context),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: 0),
                  SizedBox(
                    width: 100,
                    child: Text(
                      actor.character ?? 'Not Found',
                      maxLines: 2,
                      style: AppTextStyles.characterName(context),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
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
                          " ${movie.runtime! ~/ 60}h ${movie.runtime! % 60}m ",
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

Widget _buildSectionDivider(String title, BuildContext context) {
  final colors = Theme.of(context).colorScheme;

  return Padding(
    padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
    child: Row(
      children: [
        const SizedBox(width: 10),

        Text(title, style: AppTextStyles.titleFavorites(context)),

        Expanded(
          child: Divider(
            color: colors.primary.withAlpha(150),
            thickness: 0.8,
            height: 0,
            indent: 5,
          ),
        ),
        const SizedBox(width: 10),
      ],
    ),
  );
}
