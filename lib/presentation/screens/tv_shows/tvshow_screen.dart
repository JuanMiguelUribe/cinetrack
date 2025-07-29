import 'package:animate_do/animate_do.dart';
import 'package:movieflex/domain/entities/tv_show_details.dart';
import 'package:movieflex/infraestructure/mappers/tvshow_details_to_tvshow_mapper.dart';
import 'package:movieflex/l10n/app_localizations.dart';
import 'package:movieflex/presentation/providers/actors/actors_by_tvshow_provider.dart';
import 'package:movieflex/presentation/providers/providers.dart';
import 'package:movieflex/presentation/providers/tvshows/tvshows_details_provider.dart';
import 'package:movieflex/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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

    ref
        .read(tvshowsInfoProvider.notifier)
        .loadMovie(widget.tvshowID); // Cargar la película al iniciar
    // Cargar la película al iniciar
    ref.read(actorsByTvShowProvider.notifier).loadActors(widget.tvshowID);
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
    if (tvshow == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('${AppLocalizations.of(context)!.loading}...'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
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

class _TvShowDetails extends StatelessWidget {
  final TvShowDetails tvshow;
  const _TvShowDetails({required this.tvshow});

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
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Center(
                  child: AnimatedRatingCircle(
                    rating: tvshow.voteAverage,
                    size: 60,
                  ),
                ),
              ),
              const SizedBox(width: 1),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, left: 8),
                  child: ExpandableText(
                    text: (tvshow.overview.trim().isNotEmpty)
                        ? tvshow.overview
                        : AppLocalizations.of(context)!.resultsSearch,

                    wordLimit: 30,
                    style: textStyles.bodyMedium?.copyWith(
                      color: colors.onSurface,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5),

        // Text(tvshow.id.toString()),
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

        _ActorsByMovie(tvshowId: tvshow.id.toString()),
      ],
    );
  }
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
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
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
                      fontWeight: FontWeight.w500,
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
  final TvShowDetails tvshow;

  const _CustomSliverAppBar({required this.tvshow});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.58,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () {
            final tvshow = this.tvshow.fromTvShowDetailsToTvShowEntity();
            ref
                .watch(localStorageRepositoryProvider)
                .toggleFavoriteTvShow(tvshow);
          },
          icon: Icon(Icons.favorite_border_rounded),
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
        ? [Colors.transparent, colors.surface.withOpacity(0.91), colors.surface]
        : [Colors.transparent, colors.surface.withOpacity(0.5), colors.surface];
    return Stack(
      children: [
        SizedBox.expand(
          child: Image.network(
            tvshow.posterPath!,
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
