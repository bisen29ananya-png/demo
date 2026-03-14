import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:demo/core/design_system/app_spacing.dart';
import 'package:demo/core/routing/app_router.dart';
import 'package:demo/generated/l10n/app_localizations.dart';

@RoutePage()
class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return AutoTabsScaffold(
      routes: const [MoviesTabRoute(), FavoritesTabRoute(), SettingsTabRoute()],
      transitionBuilder: (context, child, animation) {
        return FadeTransition(
          opacity: animation,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: child,
          ),
        );
      },
      bottomNavigationBuilder: (context, tabsRouter) {
        return NavigationBar(
          height: 64,
          selectedIndex: tabsRouter.activeIndex,
          onDestinationSelected: tabsRouter.setActiveIndex,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.movie_outlined),
              selectedIcon: const Icon(Icons.movie),
              label: l10n.moviesTab,
            ),
            NavigationDestination(
              icon: const Icon(Icons.favorite_border),
              selectedIcon: const Icon(Icons.favorite),
              label: l10n.favoritesTab,
            ),
            NavigationDestination(
              icon: const Icon(Icons.settings_outlined),
              selectedIcon: const Icon(Icons.settings),
              label: l10n.settingsTab,
            ),
          ],
        );
      },
    );
  }
}
