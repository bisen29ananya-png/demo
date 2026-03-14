import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:demo/core/env/app_env.dart';
import 'package:demo/core/localization/locale_bloc.dart';
import 'package:demo/core/network/dio_factory.dart';
import 'package:demo/core/routing/app_router.dart';
import 'package:demo/core/theme/theme_bloc.dart';
import 'package:demo/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:demo/features/movies/data/datasources/movies_remote_data_source.dart';
import 'package:demo/features/movies/data/repositories/movies_repository_impl.dart';
import 'package:demo/features/movies/domain/repositories/movies_repository.dart';
import 'package:demo/features/movies/domain/usecases/get_show_details.dart';
import 'package:demo/features/movies/domain/usecases/get_shows_page.dart';
import 'package:demo/features/movies/presentation/bloc/movies_bloc.dart';

/// Service locator (DI container) for the app.
final GetIt getIt = GetIt.instance;

Future<void> configureDependencies(AppEnv env) async {
  // Core
  getIt.registerSingleton<AppEnv>(env);
  getIt.registerLazySingleton<Dio>(() => DioFactory.create(env));
  getIt.registerLazySingleton<AppRouter>(AppRouter.new);

  // App-wide blocs
  getIt.registerLazySingleton(ThemeBloc.new);
  getIt.registerLazySingleton(LocaleBloc.new);
  getIt.registerLazySingleton(FavoritesBloc.new);

  // Movies feature (clean architecture)
  getIt
    ..registerLazySingleton<MoviesRemoteDataSource>(
      () => MoviesRemoteDataSource(dio: getIt<Dio>()),
    )
    ..registerLazySingleton<MoviesRepository>(
      () => MoviesRepositoryImpl(remote: getIt<MoviesRemoteDataSource>()),
    )
    ..registerLazySingleton<GetShowsPageUseCase>(
      () => GetShowsPageUseCase(repository: getIt<MoviesRepository>()),
    )
    ..registerLazySingleton<GetShowDetailsUseCase>(
      () => GetShowDetailsUseCase(repository: getIt<MoviesRepository>()),
    )
    ..registerFactory<MoviesBloc>(
      () => MoviesBloc(getShowsPage: getIt<GetShowsPageUseCase>()),
    );
}
