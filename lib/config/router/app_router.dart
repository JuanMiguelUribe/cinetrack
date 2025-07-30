import 'package:movieflex/presentation/screens/screens.dart';
import 'package:movieflex/presentation/views/home_views/views.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: "/",
  routes: [
    //* ShellRoute para las rutas con BottomNav
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          HomeScreen(childView: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/', builder: (context, state) => const HomeView()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/categories',
              builder: (context, state) => const CategoriesView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/favorites',
              builder: (context, state) {
                return const FavoritesView();
              },
            ),
          ],
        ),
      ],
      redirect: (context, state) {
        final location = state.uri.toString();
        if (location.contains('_shell/')) {
          final parts = location.split('/');
          final indexStr = parts[parts.indexOf('_shell') + 1];
          final index = int.tryParse(indexStr);
          if (index == null || index < 0 || index >= 2) {
            return '/'; // o a donde quieras mandar
          }
        }
        return null; // dejar pasar
      },
    ),

    //* Pantallas fuera del shell, sin BottomNav
    GoRoute(
      path: '/movie/:id',
      name: MovieScreen.name,
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return MovieScreen(movieId: id);
      },
    ),
    GoRoute(
      path: '/tvshow/:id',
      name: TvShowScreen.name,
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return TvShowScreen(tvshowID: id);
      },
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
