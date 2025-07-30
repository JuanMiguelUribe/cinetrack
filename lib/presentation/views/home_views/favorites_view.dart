import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieflex/l10n/app_localizations.dart';

import 'package:movieflex/presentation/providers/providers.dart';
import 'package:movieflex/presentation/widgets/widgets.dart';

import '../../../domain/entities/movie.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  final _scrollController = ScrollController();
  final _moviesKey = GlobalKey();
  final _tvShowsKey = GlobalKey();

  bool isLastPage = false;
  bool isMoviesEmpty = false;
  bool isTvShowEmpty = false;
  bool isLoading = false;
  int movieLimit = 4;
  int tvLimit = 4;
  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;
    final movies = await ref
        .read(favoriteMoviesProvider.notifier)
        .loadNextPage();
    final tvshows = await ref
        .read(favoriteTvShowProvider.notifier)
        .loadNextPage();
    isLoading = false;

    if (movies.length < 10 && tvshows.length < 10) {
      isLastPage = true;
    }
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.pixels + 150,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _backToPosition(GlobalKey key) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = key.currentContext;
      if (context != null && mounted) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          alignment:
              0.2, // Puedes ajustar esto si quieres que quede más arriba/centrado
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();
    final favoriteTvShows = ref.watch(favoriteTvShowProvider).values.toList();

    if (favoriteMovies.isEmpty) {
      isMoviesEmpty = true;
    } else {
      isMoviesEmpty = false;
    }
    if (favoriteTvShows.isEmpty) {
      isTvShowEmpty = true;
    } else {
      isTvShowEmpty = false;
    }

    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: ClampingScrollPhysics(),
        child: SafeArea(
          child: Column(
            children: [
              MasonrySection(
                key: _moviesKey,
                title: AppLocalizations.of(context)!.myFavoriteMovies,
                movies: favoriteMovies,
                itemsToShow: movieLimit,
                showSeeMore: movieLimit < favoriteMovies.length,
                showSeeLess: movieLimit >= favoriteMovies.length,
                type: "movie",
                onSeeMore: () {
                  setState(() {
                    movieLimit += 4;
                  });
                  _scrollToBottom();
                },
                onSeeLess: () {
                  setState(() {
                    movieLimit = 4;
                  });
                  _backToPosition(_moviesKey);
                },
                isContentEmpty: isMoviesEmpty,
              ),
              MasonrySection(
                key: _tvShowsKey,
                title: AppLocalizations.of(context)!.myFavoriteTvshows,
                type: "tvshow",
                isContentEmpty: isTvShowEmpty,
                movies: favoriteTvShows
                    .map(
                      (tv) => Movie(
                        title: tv.name,
                        posterPath: tv.posterPath,
                        adult: false,
                        genreIds: tv.genreIds,
                        id: tv.id,
                        originalLanguage: tv.originalLanguage ?? "No found",
                        originalTitle: tv.originalName ?? "No Found",
                        overview: tv.overview ?? "No founded",
                        popularity: tv.popularity,
                        video: false,
                        voteAverage: tv.voteAverage,
                        voteCount: tv.voteCount,
                      ),
                    )
                    .toList(),
                itemsToShow: tvLimit,
                showSeeMore: tvLimit < favoriteTvShows.length,
                showSeeLess: tvLimit >= favoriteTvShows.length,
                onSeeMore: () {
                  setState(() {
                    tvLimit += 4;
                  });
                  _scrollToBottom();
                },
                onSeeLess: () {
                  setState(() {
                    tvLimit = 4;
                  });
                  _backToPosition(_tvShowsKey);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
