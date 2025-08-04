import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:movieflex/presentation/delegates/search_movie_series_delegate.dart';
import 'package:movieflex/presentation/providers/providers.dart';

class SearchBarWidget extends StatelessWidget {
  final WidgetRef ref;

  const SearchBarWidget({super.key, required this.ref});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: () async {
          final searchQuery = ref.read(searchQueryProvider);
          final result = await showSearch(
            context: context,
            query: searchQuery,
            delegate: SearchMovieSeriesDelegate(
              movieRepo: ref.read(movieRepositoryProvider),
              tvRepo: ref.read(tvshowsRepositoryProvider),
              ref: ref,
            ),
          );

          if (!context.mounted || result == null) return;

          if (result.type == 'movie') {
            context.push('/movie/${result.id}');
          } else {
            context.push('/tvshow/${result.id}');
          }
        },
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: colors.surfaceVariant.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Icon(Icons.search, color: colors.onSurface),
              const SizedBox(width: 8),
              Text(
                'Search movies or series...',
                style: TextStyle(color: colors.onSurface.withOpacity(0.8)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
