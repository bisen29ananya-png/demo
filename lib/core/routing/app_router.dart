import 'package:auto_route/auto_route.dart';

import 'package:demo/features/favorites/presentation/pages/favorites_page.dart';
import 'package:demo/features/movies/presentation/pages/movie_details_page.dart';
import 'package:demo/features/movies/presentation/pages/movies_list_page.dart';
import 'package:demo/features/settings/presentation/pages/settings_page.dart';
import 'package:demo/features/shell/presentation/pages/root_page.dart';
import 'package:demo/features/shell/presentation/pages/tabs/favorites_tab_page.dart';
import 'package:demo/features/shell/presentation/pages/tabs/movies_tab_page.dart';
import 'package:demo/features/shell/presentation/pages/tabs/settings_tab_page.dart';
import 'package:flutter/widgets.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: RootRoute.page,
      initial: true,
      path: '/',
      children: [
        AutoRoute(
          page: MoviesTabRoute.page,
          initial: true,
          path: 'movies',
          children: [
            AutoRoute(page: MoviesListRoute.page, initial: true, path: ''),
            AutoRoute(page: MovieDetailsRoute.page, path: ':id'),
          ],
        ),
        AutoRoute(
          page: FavoritesTabRoute.page,
          path: 'favorites',
          children: [
            AutoRoute(page: FavoritesRoute.page, initial: true, path: ''),
          ],
        ),
        AutoRoute(
          page: SettingsTabRoute.page,
          path: 'settings',
          children: [
            AutoRoute(page: SettingsRoute.page, initial: true, path: ''),
          ],
        ),
      ],
    ),
  ];
}
