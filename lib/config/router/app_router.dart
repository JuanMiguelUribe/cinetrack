import 'package:cinetrack/presentation/screens/screens.dart';
import 'package:cinetrack/presentation/views/home_views/views.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: "/",
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return HomeScreen(childView: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: "/",
              builder: (context, state) {
                return const HomeView();
              },
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
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/favorites',
              builder: (context, state) => const FavoritesView(),
            ),
          ],
        ),
      ],
    ),

    //*Rutas Padre/Hijo, funciona
    // GoRoute(
    //   path: "/",
    //   name: HomeScreen.name,
    //   builder: (context, state) => const HomeScreen(childView: HomeView()),
    //   routes: [
    //     GoRoute(
    //       path: "movie/:id",
    //       name: MovieScreen.name,
    //       builder: (context, state) {
    //         final movieId = state.pathParameters['id'] ?? "no-id";
    //         return MovieScreen(movieId: movieId);
    //       },
    //     ),
    //     GoRoute(
    //       path: "tvshow/:id",
    //       name: TvShowScreen.name,
    //       builder: (context, state) {
    //         final tvshowId = state.pathParameters['id'] ?? "no-id";
    //         return TvShowScreen(tvshowID: tvshowId);
    //       },
    //     ),
    //   ],
    // ),
  ],
);
