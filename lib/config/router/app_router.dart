import 'package:cinemapedia_app/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/home/0', routes: [
  GoRoute(
      path: '/home/:page',
      name: LayoutScreen.name,
      builder: (context, state) => LayoutScreen(
            page: int.parse(state.pathParameters['page'] ?? '0'),
            param: state.extra,
          ),
      routes: [
        GoRoute(
            path: 'movie/:id',
            name: MovieScreen.name,
            builder: (context, state) =>
                MovieScreen(movieId: state.pathParameters['id'] ?? ''))
      ]),
  GoRoute(
    path: '/',
    redirect: (_, __) => '/home/0',
  )
]);
