import 'package:animate_do/animate_do.dart';
import 'package:cinetrack/domain/entities/searchbleitem.dart';
import 'package:cinetrack/infraestructure/repositories/movie_repository_imple.dart';
import 'package:cinetrack/infraestructure/repositories/tvshows_repository_impl.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

typedef SearchMoviesCallBack =
    Future<List<SearchableItem>> Function(String query);

class SearchMovieSeriesDelegate extends SearchDelegate<SearchableItem?> {
  final MovieRepositoryImple movieRepo;
  final TvshowsDbRepositoryImpl tvRepo;

  SearchMovieSeriesDelegate({required this.movieRepo, required this.tvRepo});

  Future<List<SearchableItem>> _search(String query) async {
    final movies = await movieRepo.searchMovies(query);
    final tvShows = await tvRepo.searchtvshow(query);

    final movieItems = movies.map(
      (m) => SearchableItem(
        id: m.id,
        title: m.title,
        posterPath: m.posterPath!,
        type: 'movie',
      ),
    );

    final tvItems = tvShows.map(
      (tv) => SearchableItem(
        id: tv.id,
        title: tv.name,
        posterPath: tv.posterPath!,
        type: 'tv',
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
    onPressed: () => close(context, null),
  );

  @override
  Widget buildResults(BuildContext context) {
    return const Text("BuilResults");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return const Center(child: Text(""));

    return FutureBuilder<List<SearchableItem>>(
      future: _search(query),
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
            return _ContentItem(content: item);

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
  const _ContentItem({required this.content});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
