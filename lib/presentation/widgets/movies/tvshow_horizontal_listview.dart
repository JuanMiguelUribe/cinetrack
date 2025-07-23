import 'package:animate_do/animate_do.dart';
import 'package:cinetrack/config/helpers/human_formats.dart';
import 'package:cinetrack/domain/entities/tv_shows.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TvShowHorizontalListView extends StatefulWidget {
  final List<TvShow> tvShows;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;

  const TvShowHorizontalListView({
    super.key,
    required this.tvShows,
    this.title,
    this.subtitle,
    this.loadNextPage,
  });

  @override
  State<TvShowHorizontalListView> createState() =>
      _TvShowHorizontalListViewState();
}

class _TvShowHorizontalListViewState extends State<TvShowHorizontalListView> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;
      if (scrollController.position.pixels + 50 >=
          scrollController.position.maxScrollExtent - 500) {
        widget.loadNextPage!();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: Column(
        children: [
          if (widget.title != null || widget.subtitle != null)
            _Title(title: widget.title, subtitle: widget.subtitle),
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              itemCount: widget.tvShows.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return _TvShowSlide(tvShow: widget.tvShows[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TvShowSlide extends StatelessWidget {
  final TvShow tvShow;
  const _TvShowSlide({required this.tvShow});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => context.push('/tvshow/${tvShow.id}'),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* Imagen
            SizedBox(
              width: 150,
              height: 225,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  tvShow.posterPath,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return FadeIn(child: child);
                  },
                ),
              ),
            ),
            const SizedBox(height: 5),
            //* Nombre
            SizedBox(
              width: 150,
              child: Text(
                tvShow.name,
                maxLines: 2,
                style: const TextStyle(fontSize: 15),
              ),
            ),
            //* Rating
            SizedBox(
              width: 150,
              child: Row(
                children: [
                  Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
                  Text(
                    tvShow.voteAverage.toStringAsFixed(1),
                    style: textStyles.bodyMedium?.copyWith(
                      color: Colors.yellow.shade800,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    HumanFormats.humanReadbleNumber(tvShow.popularity),
                    style: textStyles.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({this.title, this.subtitle});
  final String? title;
  final String? subtitle;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(right: 15, left: 15, top: 10),
      child: Row(
        children: [
          if (title != null)
            Text(
              title!,
              style: GoogleFonts.robotoFlex(
                fontSize: 20,
                color: colors.onSurface,
                fontWeight: FontWeight.normal,
                // background:
                // Puedes probar: 'Cinzel', 'Bebas Neue', 'Playfair Display', etc.
              ),
            ),
          Spacer(),
          if (subtitle != null)
            FilledButton.tonal(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {},
              child: Text(toBeginningOfSentenceCase(subtitle!)),
            ),
        ],
      ),
    );
  }
}
