import 'package:cinetrack/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: "movie/:id",
          name: MovieScreen.name,
          builder: (context, state) {
            final movieId = state.pathParameters['id'] ?? "no-id";
            return MovieScreen(movieId: movieId);
          },
        ),
        GoRoute(
          path: "tvshow/:id",
          name: TvShowScreen.name,
          builder: (context, state) {
            final tvshowId = state.pathParameters['id'] ?? "no-id";
            return TvShowScreen(tvshowID: tvshowId);
          },
        ),
      ],
    ),
  ],
);
