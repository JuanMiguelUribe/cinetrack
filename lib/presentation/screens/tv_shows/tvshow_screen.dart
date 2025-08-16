import 'package:animate_do/animate_do.dart';
import 'package:movieflex/config/theme/app_text_styles.dart';
import 'package:movieflex/domain/entities/tv_show_details.dart';
import 'package:movieflex/infraestructure/datasources/tvshows_datasource.dart';
import 'package:movieflex/infraestructure/mappers/tvshow_details_to_tvshow_mapper.dart';
import 'package:movieflex/l10n/app_localizations.dart';
import 'package:movieflex/presentation/providers/actors/actors_by_tvshow_provider.dart';
import 'package:movieflex/presentation/providers/providers.dart';
import 'package:movieflex/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/seasons.dart';

class TvShowScreen extends ConsumerStatefulWidget {
  static const name = "tvshow-screen";
  final String tvshowID;

  const TvShowScreen({super.key, required this.tvshowID});

  @override
  TvShowScreenState createState() => TvShowScreenState();
}

class TvShowScreenState extends ConsumerState<TvShowScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await ref.read(tvshowsInfoProvider.notifier).loadMovie(widget.tvshowID);
    await ref.read(actorsByTvShowProvider.notifier).loadActors(widget.tvshowID);

    if (!mounted) return;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TvShowDetails? tvshow = ref.watch(
      tvshowsInfoProvider,
    )[widget.tvshowID];
    final colors = Theme.of(context).colorScheme;
    if (!mounted) return const SizedBox.shrink();

    if (tvshow == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('${AppLocalizations.of(context)!.loading}...'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showTrailerDialog(context, tvshow.id, MediaType.tv),
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
          _CustomSliverAppBar(tvshow: tvshow),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _TvShowDetails(tvshow: tvshow),
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _TvShowDetails extends ConsumerWidget {
  final TvShowDetails tvshow;
  const _TvShowDetails({required this.tvshow});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    final numberOfSeasons = tvshow.numberOfSeasons ?? 1;
    final seasonNumbers = List.generate(numberOfSeasons, (i) => i + 1);
    // print(seasonNumbers);

    final selectedSeason = ref.watch(selectedSeasonProvider);
    final asyncSeason = ref.watch(
      tvShowSeasonsProvider((tvshow.id.toString(), selectedSeason)),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 3),
        Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            children: tvshow.genres
                .map((genre) => GenreChip(label: genre, size: 1.2))
                .toList(),
          ),
        ),
        SizedBox(height: 3),
        if (tvshow.adult)
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

        //*Rating y overview de la serie
        _RatingAndOverview(
          tvshow: tvshow,
          textStyles: textStyles,
          colors: colors,
        ),

        // SizedBox(height: 5),
        //*DIVISOR DE SECCIÓN,
        _buildSectionDivider("", context),

        //*Titulo de episodios
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            AppLocalizations.of(context)!.episodes,
            textAlign: TextAlign.center,
            style: AppTextStyles.titlesForDetailScreen(context),
          ),
        ),
        SizedBox(height: 5),

        //*Dropdown button para temporada
        _SeasonSelector(
          selectedSeason: selectedSeason,
          seasonNumbers: seasonNumbers,
        ),
        const SizedBox(height: 16),

        //*CARDS DE CADA EPISODIO
        asyncSeason.when(
          data: (season) {
            return _CardsForEpisodes(season: season);
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) {
            final errorMessage = (e is Failure)
                ? e.message
                : "An error occurred while loading the information.";

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
                  const SizedBox(height: 8),
                  Text(errorMessage, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        ),

        //*DIVISOR DE SECCIÓN,
        _buildSectionDivider("", context),
        // Text(tvshow.id.toString()),
        //*Titulo del Cast
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
        _ActorsByMovie(tvshowId: tvshow.id.toString()),

        //*DIVISOR DE SECCIÓN,
        _buildSectionDivider("", context),

        //*Videos de la Pelicula
        TrailerCarousel(movieId: tvshow.id, type: MediaType.tv),

        //*DIVISOR DE SECCIÓN,
        _buildSectionDivider("", context),

        //*Titulo de recomendaciones
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            AppLocalizations.of(context)!.recommendations_title,
            textAlign: TextAlign.center,
            style: AppTextStyles.titlesForDetailScreen(context),
          ),
        ),
        //*Lista de recomendaciones
        _RecomendationsListVIew(tvshowId: tvshow.id.toString()),

        SizedBox(height: 50),
      ],
    );
  }
}

class _CardsForEpisodes extends StatelessWidget {
  final Season season;
  const _CardsForEpisodes({required this.season});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,

      child: Padding(
        padding: const EdgeInsets.only(left: 11, right: 11),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemCount: season.episodes.length,
          itemBuilder: (context, index) {
            final episode = season.episodes[index];
            return AspectRatio(
              aspectRatio: 16 / 9, // ancho de cada tarjeta
              child: Card(
                clipBehavior: Clip.hardEdge,
                child: Stack(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (episode!.stillPath != null)
                      Image.network(
                        episode.stillPath!,
                        // height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    else
                      Container(
                        height: 100,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.image_not_supported),
                        ),
                      ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 30,
                        ),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Colors.black87, Colors.transparent],
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 4), // Baja el texto
                          child: Align(alignment: Alignment.bottomCenter),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Row(
                          children: [
                            Text(
                              "${AppLocalizations.of(context)!.season_abbreviation}${episode.seasonNumber.toString()}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "E${episode.episodeNumber.toString()}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(width: 8),

                            Text(
                              episode.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.white,
                              ),

                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
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
    );
  }
}

class _SeasonSelector extends ConsumerWidget {
  const _SeasonSelector({
    required this.selectedSeason,
    required this.seasonNumbers,
  });

  final int selectedSeason;
  final List<int> seasonNumbers;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),

        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            menuMaxHeight: 300,

            value: selectedSeason,
            icon: const Icon(Icons.arrow_drop_down),
            items: seasonNumbers.map((season) {
              return DropdownMenuItem<int>(
                value: season,
                child: Text("${AppLocalizations.of(context)!.season} $season"),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                ref.read(selectedSeasonProvider.notifier).state = value;
              }
            },
          ),
        ),
      ),
    );
  }
}

class _RecomendationsListVIew extends ConsumerWidget {
  final String tvshowId;
  const _RecomendationsListVIew({required this.tvshowId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recommendationsTvShow = ref.watch(
      recommendationsNotifierProviderTvShow(tvshowId),
    );

    return TvShowHorizontalListView(
      tvShows: recommendationsTvShow,
      loadNextPage: () => ref
          .read(recommendationsNotifierProvider(tvshowId).notifier)
          .loadNextPage(),
    );
  }
}

class _RatingAndOverview extends StatefulWidget {
  const _RatingAndOverview({
    required this.tvshow,
    required this.textStyles,
    required this.colors,
  });

  final TvShowDetails tvshow;
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
                  color: Colors.black.withAlpha(80),
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
                        rating: widget.tvshow.voteAverage,
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
                        text: (widget.tvshow.overview.trim().isNotEmpty)
                            ? widget.tvshow.overview
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
                            color: Colors.black.withAlpha(80),
                            blurRadius: 8,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildDetailItem(
                            context,
                            AppLocalizations.of(context)!.details_title,
                            widget.tvshow.originalName!,
                          ),
                          buildDetailItem(
                            context,
                            AppLocalizations.of(context)!.first_air_episode,
                            widget.tvshow.firstAirDate != null
                                ? DateFormat(
                                    'd MMMM y',
                                  ).format(widget.tvshow.firstAirDate!)
                                : AppLocalizations.of(context)!.unknownDate,
                          ),
                          buildDetailItem(
                            context,
                            AppLocalizations.of(context)!.last_air_episode,
                            widget.tvshow.lastAirDate != null
                                ? DateFormat(
                                    'd MMMM y',
                                  ).format(widget.tvshow.lastAirDate!)
                                : AppLocalizations.of(context)!.unknownDate,
                          ),
                          buildDetailItem(
                            context,
                            AppLocalizations.of(context)!.details_tagline,
                            widget.tvshow.tagline.toString(),
                          ),
                          buildDetailItem(
                            context,
                            AppLocalizations.of(context)!.details_language,
                            widget.tvshow.originalLanguage.toUpperCase(),
                          ),
                          buildDetailItem(
                            context,
                            AppLocalizations.of(context)!.status,
                            widget.tvshow.status,
                          ),
                          buildDetailItem(
                            context,
                            AppLocalizations.of(context)!.created_by,
                            widget.tvshow.createdBy.join(", "),
                          ),
                          buildDetailItem(
                            context,
                            AppLocalizations.of(context)!.in_production,
                            widget.tvshow.inProduction.toString() == "true"
                                ? AppLocalizations.of(context)!.yes_response
                                : AppLocalizations.of(context)!.no_response,
                          ),

                          buildDetailItem(
                            context,
                            AppLocalizations.of(
                              context,
                            )!.details_production_companies,
                            widget.tvshow.productionCompanies.join(", "),
                          ),
                          buildDetailItem(
                            context,
                            AppLocalizations.of(
                              context,
                            )!.details_production_countries,
                            widget.tvshow.productionCountries.join(", "),
                          ),
                          buildDetailItem(
                            context,
                            AppLocalizations.of(
                              context,
                            )!.details_spoken_languages,
                            widget.tvshow.spokenLanguages.join(", "),
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

Widget buildDetailItem(BuildContext context, String title, String value) {
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
  final String tvshowId;
  const _ActorsByMovie({required this.tvshowId});

  @override
  Widget build(BuildContext context, ref) {
    final actorsByTvshow = ref.watch(actorsByTvShowProvider);
    if (actorsByTvshow[tvshowId] == null) {
      return const CircularProgressIndicator(strokeWidth: 2);
    }
    final actors = actorsByTvshow[tvshowId]!;

    return SizedBox(
      height: 242,
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: actors.length,
          itemBuilder: (context, index) {
            final actor = actors[index];
            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) =>
                      ActorDetailsBottomSheet(actorId: actor.id.toString()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInRight(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
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
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CustomSliverAppBar extends ConsumerWidget {
  final TvShowDetails tvshow;

  const _CustomSliverAppBar({required this.tvshow});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final isFavoriteFuture = ref.watch(
      isFavoriteProvider((type: 'tvshow', id: tvshow.id)),
    );

    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.58,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () async {
            final tvshow = this.tvshow.fromTvShowDetailsToTvShowEntity();
            await
            //     .read(localStorageRepositoryProvider)
            //     .toggleFavoriteTvShow(tvshow);
            ref.read(favoriteTvShowProvider.notifier).toggleFavorite(tvshow);
            ref.invalidate(isFavoriteProvider((type: 'tvshow', id: tvshow.id)));
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
              tvshow.name,
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
                          "${tvshow.firstAirDate != null ? DateFormat('d MMMM y').format(tvshow.firstAirDate!) : AppLocalizations.of(context)!.unknownDate} •",
                      style: TextStyle(color: colors.onSurface),
                    ),
                    TextSpan(
                      text:
                          "  ${tvshow.numberOfSeasons} Season${tvshow.numberOfSeasons == 1 ? "" : "s"}",
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
        background: _BackgroundStack(tvshow: tvshow),
      ),
    );
  }
}

class _BackgroundStack extends StatelessWidget {
  final TvShowDetails tvshow;
  const _BackgroundStack({required this.tvshow});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final gradientColors = isDarkMode
        ? [Colors.transparent, colors.surface.withAlpha(200), colors.surface]
        : [Colors.transparent, colors.surface.withAlpha(150), colors.surface];
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.network(
            tvshow.posterPath!,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) {
                return const Center(child: CircularProgressIndicator());
              }

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
    this.begin = Alignment.center,
    this.end = Alignment.bottomCenter,
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
            indent: 5,
          ),
        ),
        const SizedBox(width: 10),
      ],
    ),
  );
}

String formatDate(DateTime? date) {
  if (date == null) return 'Sin fecha';
  try {
    return DateFormat('dd/MM/yyyy').format(date);
  } catch (_) {
    return 'Fecha inválida';
  }
}
