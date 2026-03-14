// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [FavoritesPage]
class FavoritesRoute extends PageRouteInfo<void> {
  const FavoritesRoute({List<PageRouteInfo>? children})
    : super(FavoritesRoute.name, initialChildren: children);

  static const String name = 'FavoritesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FavoritesPage();
    },
  );
}

/// generated route for
/// [FavoritesTabPage]
class FavoritesTabRoute extends PageRouteInfo<void> {
  const FavoritesTabRoute({List<PageRouteInfo>? children})
    : super(FavoritesTabRoute.name, initialChildren: children);

  static const String name = 'FavoritesTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FavoritesTabPage();
    },
  );
}

/// generated route for
/// [MovieDetailsPage]
class MovieDetailsRoute extends PageRouteInfo<MovieDetailsRouteArgs> {
  MovieDetailsRoute({Key? key, required int id, List<PageRouteInfo>? children})
    : super(
        MovieDetailsRoute.name,
        args: MovieDetailsRouteArgs(key: key, id: id),
        rawPathParams: {'id': id},
        initialChildren: children,
      );

  static const String name = 'MovieDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<MovieDetailsRouteArgs>(
        orElse: () => MovieDetailsRouteArgs(id: pathParams.getInt('id')),
      );
      return MovieDetailsPage(key: args.key, id: args.id);
    },
  );
}

class MovieDetailsRouteArgs {
  const MovieDetailsRouteArgs({this.key, required this.id});

  final Key? key;

  final int id;

  @override
  String toString() {
    return 'MovieDetailsRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [MoviesListPage]
class MoviesListRoute extends PageRouteInfo<void> {
  const MoviesListRoute({List<PageRouteInfo>? children})
    : super(MoviesListRoute.name, initialChildren: children);

  static const String name = 'MoviesListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MoviesListPage();
    },
  );
}

/// generated route for
/// [MoviesTabPage]
class MoviesTabRoute extends PageRouteInfo<void> {
  const MoviesTabRoute({List<PageRouteInfo>? children})
    : super(MoviesTabRoute.name, initialChildren: children);

  static const String name = 'MoviesTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MoviesTabPage();
    },
  );
}

/// generated route for
/// [RootPage]
class RootRoute extends PageRouteInfo<void> {
  const RootRoute({List<PageRouteInfo>? children})
    : super(RootRoute.name, initialChildren: children);

  static const String name = 'RootRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RootPage();
    },
  );
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsPage();
    },
  );
}

/// generated route for
/// [SettingsTabPage]
class SettingsTabRoute extends PageRouteInfo<void> {
  const SettingsTabRoute({List<PageRouteInfo>? children})
    : super(SettingsTabRoute.name, initialChildren: children);

  static const String name = 'SettingsTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsTabPage();
    },
  );
}
