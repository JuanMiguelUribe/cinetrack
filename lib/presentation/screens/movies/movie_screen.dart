import 'package:cinetrack/domain/entities/movie.dart';
import 'package:cinetrack/presentation/providers/movies/movie_details_provider.dart';
import 'package:cinetrack/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinetrack/presentation/widgets/shared/expandable_text.dart';

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
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Cargando...')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
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
  final Movie movie;
  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: AnimatedRatingCircle(rating: movie.voteAverage),
                ),
              ),
              const SizedBox(width: 3),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),

                  child: ExpandableText(
                    text: movie.overview,
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
        SizedBox(height: 10),
        Placeholder(),
      ],
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.58,
      foregroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "${movie.releaseDate.year} • ${movie.genreIds.join(', ')} ",
                style: TextStyle(fontSize: 10, color: colors.onSurface),
                textAlign: TextAlign.center,
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
  final Movie movie;
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
          child: Image.network(movie.posterPath, fit: BoxFit.cover),
        ),

        SizedBox.expand(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.8, 0.9, 1.0],
                colors: gradientColors,
              ),
            ),
          ),
        ),
        SizedBox.expand(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,

                stops: const [0.0, 0.2],
                colors: [colors.surface, Colors.transparent],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
