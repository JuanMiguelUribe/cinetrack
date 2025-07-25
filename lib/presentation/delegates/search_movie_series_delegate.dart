import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinetrack/domain/entities/searchbleitem.dart';
import 'package:cinetrack/infraestructure/repositories/movie_repository_imple.dart';
import 'package:cinetrack/infraestructure/repositories/tvshows_repository_impl.dart';

import 'package:cinetrack/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../config/theme/app_text_styles.dart';
import '../../l10n/app_localizations.dart';

typedef SearchMoviesCallBack =
    Future<List<SearchableItem>> Function(String query);

class SearchMovieSeriesDelegate extends SearchDelegate<SearchableItem?> {
  final MovieRepositoryImple movieRepo;
  final TvshowsDbRepositoryImpl tvRepo;

  SearchMovieSeriesDelegate({required this.movieRepo, required this.tvRepo});

  StreamController<List<SearchableItem>> debouncedContent =
      StreamController.broadcast();

  void cleanStreams() {
    debouncedContent.close();
  }

  //*ESTO SE PUEDE METER EN UNA CLASE
  Timer? _debounceTimer;

  void _onQueryChanged(String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        debouncedContent.add([]);
        return;
      }

      final content = await _search(query);
      debouncedContent.add(content);
    });
  }

  Future<List<SearchableItem>> _search(String query) async {
    final movies = await movieRepo.searchMovies(query);
    final tvShows = await tvRepo.searchtvshow(query);

    final movieItems = movies.map(
      (m) => SearchableItem(
        id: m.id,
        title: m.title,
        posterPath: m.posterPath!,
        type: 'movie',
        overview: m.overview,
        popularity: m.voteAverage,
      ),
    );

    final tvItems = tvShows.map(
      (tv) => SearchableItem(
        id: tv.id,
        title: tv.name,
        posterPath: tv.posterPath!,
        type: 'tv',
        overview: tv.overview ?? "",
        popularity: tv.voteAverage,
      ),
    );

    final results = [...movieItems, ...tvItems].toList();
    return results;
  }

  @override
  String get searchFieldLabel => "Batman, Stranger Things, Loki...";
  @override
  List<Widget>? buildActions(BuildContext context) => [
    if (query.isNotEmpty)
      FadeIn(
        animate: query.isNotEmpty,
        duration: const Duration(milliseconds: 200),
        child: IconButton(
          icon: const Icon(Icons.clear_outlined),
          onPressed: () => query = '',
        ),
      ),
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back_ios_new_rounded),
    onPressed: () {
      cleanStreams();
      close(context, null);
    },
  );

  @override
  Widget buildResults(BuildContext context) {
    return const Text("BuilResults");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);

    return StreamBuilder(
      // future: _search(query),
      stream: debouncedContent.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(AppLocalizations.of(context)!.resultsSearch),
          );
        }

        final results = snapshot.data ?? [];

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final item = results[index];
            return _ContentItem(
              content: item,
              onContentSelected: (context, result) {
                close(context, result);
              },
            );

            // return ListTile(
            //   leading: Image.network(
            //     item.posterPath,
            //     width: 50,
            //     fit: BoxFit.cover,
            //   ),

            //   title: Text(item.title),
            //   subtitle: Text(item.type == 'movie' ? '🎬 Movie' : '📺 TV Show'),
            //   onTap: () => close(context, item),
            // );
          },
        );
      },
    );
  }
}

class _ContentItem extends StatelessWidget {
  final SearchableItem content;
  final Function onContentSelected;
  const _ContentItem({required this.content, required this.onContentSelected});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: GestureDetector(
        onTap: () {
          onContentSelected(context, content);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).colorScheme.surface, // Fondo amigable al tema
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //*Image
                  SizedBox(
                    width: size.width * 0.2,

                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(15),
                      child: Image.network(
                        content.posterPath,
                        loadingBuilder: (context, child, loadingProgress) {
                          return FadeIn(child: child);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  //*Description
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: size.width * 0.48,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            content.title,
                            maxLines: 2,
                            style: AppTextStyles.titleMovieSearch(context),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: 5),

                          (content.overview.length > 100)
                              ? //*First condition
                                ((content.overview != "")
                                    ? Text(
                                        "${content.overview.substring(0, 100)}...",
                                        textAlign: TextAlign.justify,
                                        style:
                                            AppTextStyles.overviewMovieSearch(
                                              context,
                                            ),
                                      )
                                    : Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.resultsSearch,
                                        style:
                                            AppTextStyles.overviewMovieSearch(
                                              context,
                                            ),
                                      ))
                              //*Second condition
                              : (content.overview != "")
                              ? Text(
                                  content.overview,
                                  textAlign: TextAlign.justify,
                                  style: AppTextStyles.overviewMovieSearch(
                                    context,
                                  ),
                                )
                              : Text(
                                  AppLocalizations.of(context)!.resultsSearch,
                                  style: AppTextStyles.overviewMovieSearch(
                                    context,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedRatingCircle(
                            rating: content.popularity,
                            size: 25,
                          ),
                          //* TYPE OF CONTENT
                          (content.type == "movie")
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        const SizedBox(height: 6),
                                        Icon(
                                          Icons.local_movies,
                                          size: 15,
                                          color: colors.tertiary,
                                        ),

                                        Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.movieSearch,
                                          style: AppTextStyles.typeMovieSearch(
                                            context,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 6),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.tv,
                                          size: 15,
                                          color: colors.tertiary,
                                        ),
                                        Text(
                                          AppLocalizations.of(
                                            context,
                                          )!.tvshowSearch,
                                          style: AppTextStyles.typeMovieSearch(
                                            context,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
