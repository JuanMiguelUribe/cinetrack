import 'package:animate_do/animate_do.dart';
import 'package:movieflex/config/helpers/human_formats.dart';
import 'package:movieflex/config/theme/app_text_styles.dart';
import 'package:movieflex/domain/entities/actor.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:movieflex/infraestructure/models/movieDb/credits_actor_response.dart';

class CombinedHorizontalListView extends StatefulWidget {
  final List<ActorCredit> combined;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;
  final Color? color;

  const CombinedHorizontalListView({
    super.key,
    required this.combined,
    this.title,
    this.subtitle,
    this.loadNextPage,
    this.color,
  });

  @override
  State<CombinedHorizontalListView> createState() =>
      _CombinedHorizontalListViewState();
}

class _CombinedHorizontalListViewState
    extends State<CombinedHorizontalListView> {
  // final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    // scrollController.addListener(() {
    //   if (widget.loadNextPage == null) return;
    //   if (scrollController.position.pixels + 50 >=
    //       scrollController.position.maxScrollExtent - 500) {
    //     widget.loadNextPage!();
    //   }
    // });
    super.initState();
  }

  @override
  void dispose() {
    // scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: Column(
        children: [
          if (widget.title != null || widget.subtitle != null)
            _Title(
              title: widget.title,
              subtitle: widget.subtitle,
              color: widget.color,
            ),
          const SizedBox(height: 5),
          SizedBox(
            height: 300,

            child: Padding(
              padding: const EdgeInsets.only(left: 0),
              child: ListView.builder(
                itemCount: widget.combined.length,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return _CombinedSlide(combined: widget.combined[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CombinedSlide extends StatelessWidget {
  final ActorCredit combined;
  const _CombinedSlide({required this.combined});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        if (combined.mediaType == MediaType.movie) {
          context.push('/movie/${combined.id}');
        } else if (combined.mediaType == MediaType.tv) {
          context.push('/tvshow/${combined.id}');
        } else {
          context.push('/');
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* Imagen
            SizedBox(
              width: 130,
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  combined.posterUrl,
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
              width: 130,
              child: Text(
                combined.title,
                maxLines: 2,
                style: const TextStyle(fontSize: 15),
              ),
            ),
            //* Rating
            SizedBox(
              width: 130,
              child: Row(
                children: [
                  Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
                  Text(
                    combined.voteAverage.toStringAsFixed(1),
                    style: textStyles.bodyMedium?.copyWith(
                      color: Colors.yellow.shade800,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.people_alt,
                    color: Colors.green.shade500,
                    size: 20,
                  ),
                  SizedBox(width: 2),
                  Text(
                    HumanFormats.humanReadbleNumber(combined.popularity),
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
  const _Title({this.title, this.subtitle, this.color = Colors.black});
  final String? title;
  final String? subtitle;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15, left: 15, top: 10),
      child: Row(
        children: [
          if (title != null)
            Text(
              title!.toUpperCase(),
              style: AppTextStyles.sectionTitle(context).copyWith(color: color),
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
