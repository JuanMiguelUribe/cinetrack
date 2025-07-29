import 'package:movieflex/presentation/delegates/search_movie_series_delegate.dart';
import 'package:movieflex/presentation/providers/movies/movies_respository_provider.dart';
import 'package:movieflex/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final colors = Theme.of(context).colorScheme;
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              const SizedBox(width: 10),

              RichText(
                text: TextSpan(
                  style: GoogleFonts.robotoFlex(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: "Movie",
                      style: TextStyle(color: colors.onSurface),
                    ),
                    TextSpan(
                      text: "Flex",
                      style: TextStyle(color: colors.primary),
                    ),
                  ],
                ),
              ),

              Spacer(),
              IconButton(
                onPressed: () async {
                  final searchQuery = ref.read(searchQueryProvider);
                  final result = await showSearch(
                    query: searchQuery,
                    context: context,
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

                icon: Icon(Icons.search, color: colors.onSurface),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
