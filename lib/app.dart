import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:demo/core/injection/service_locator.dart';
import 'package:demo/core/env/app_env.dart';
import 'package:demo/core/routing/app_router.dart';
import 'package:demo/core/localization/locale_bloc.dart';
import 'package:demo/core/theme/theme_bloc.dart';
import 'package:demo/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:demo/generated/l10n/app_localizations.dart';

class App extends StatelessWidget {
  const App({super.key, required this.env});

  final AppEnv env;

  @override
  Widget build(BuildContext context) {
    final router = getIt<AppRouter>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ThemeBloc>()),
        BlocProvider(create: (_) => getIt<LocaleBloc>()),
        BlocProvider(create: (_) => getIt<FavoritesBloc>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LocaleBloc, LocaleState>(
            builder: (context, localeState) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: 'Demo',
                routerConfig: router.config(),
                theme: themeState.lightTheme,
                darkTheme: themeState.darkTheme,
                themeMode: themeState.themeMode,
                locale: localeState.locale,
                supportedLocales: AppLocalizations.supportedLocales,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
              );
            },
          );
        },
      ),
    );
  }
}
