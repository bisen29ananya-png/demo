import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:demo/core/design_system/app_spacing.dart';
import 'package:demo/core/routing/app_router.dart';
import 'package:demo/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:demo/generated/l10n/app_localizations.dart';

@RoutePage()
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.favoritesTitle),
        actions: [
          IconButton(
            onPressed: () =>
                context.read<FavoritesBloc>().add(const FavoritesCleared()),
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Clear',
          ),
        ],
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          final items = state.items;
          if (items.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Text(
                  'No favorites yet. Add some from a movie details page.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.sm),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, index) {
              final show = items[index];

              return Card(
                clipBehavior: Clip.antiAlias,
                child: ListTile(
                  onTap: () =>
                      context.router.push(MovieDetailsRoute(id: show.id)),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: 48,
                      height: 48,
                      child: show.imageMedium == null
                          ? ColoredBox(
                              color: Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHighest,
                            )
                          : CachedNetworkImage(
                              imageUrl: show.imageMedium!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  title: Text(
                    show.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    show.genres.take(3).join(' • '),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    onPressed: () => context.read<FavoritesBloc>().add(
                      FavoriteToggled(show),
                    ),
                    icon: const Icon(Icons.favorite),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
