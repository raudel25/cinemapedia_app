import 'package:cinemapedia_app/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  ShellRoute(
      builder: (context, state, child) => LayoutScreen(screen: child),
      routes: [
        GoRoute(
            path: '/',
            name: HomeScreen.name,
            builder: (context, state) => const HomeScreen(),
            routes: [
              GoRoute(
                  path: 'movie/:id',
                  name: MovieScreen.name,
                  builder: (context, state) =>
                      MovieScreen(movieId: state.pathParameters['id'] ?? ''))
            ]),
        GoRoute(
            path: '/categories',
            name: CategoriesScreen.name,
            builder: (context, state) => const CategoriesScreen()),
        GoRoute(
            path: '/favorites',
            name: FavoritesScreen.name,
            builder: (context, state) => const FavoritesScreen())
      ])
]);
