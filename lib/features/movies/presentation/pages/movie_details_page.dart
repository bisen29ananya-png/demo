import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:demo/core/design_system/app_spacing.dart';
import 'package:demo/core/injection/service_locator.dart';
import 'package:demo/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:demo/features/movies/domain/entities/show.dart';
import 'package:demo/features/movies/domain/usecases/get_show_details.dart';
import 'package:demo/generated/l10n/app_localizations.dart';

@RoutePage()
class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({super.key, @PathParam('id') required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.movieDetails)),
      body: FutureBuilder<Show>(
        future: getIt<GetShowDetailsUseCase>()(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final show = snapshot.data;
          if (show == null) {
            return Center(child: Text(l10n.errorGeneric));
          }

          final favorites = context.watch<FavoritesBloc>().state;
          final isFavorite = favorites.ids.contains(show.id);

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              if (show.imageOriginal != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: CachedNetworkImage(
                      imageUrl: show.imageOriginal!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      show.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  IconButton(
                    onPressed: () => context.read<FavoritesBloc>().add(
                      FavoriteToggled(show),
                    ),
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.xs,
                children: [
                  if (show.rating != null)
                    _Chip(
                      text:
                          '${l10n.rating}: ${show.rating!.toStringAsFixed(1)}',
                    ),
                  if (show.premiered != null)
                    _Chip(
                      text:
                          '${l10n.premiered}: ${show.premiered!.toIso8601String().split('T').first}',
                    ),
                  if (show.genres.isNotEmpty)
                    _Chip(
                      text: '${l10n.genres}: ${show.genres.take(4).join(', ')}',
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              if ((show.summary ?? '').isNotEmpty)
                Text(
                  _stripHtml(show.summary!),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
            ],
          );
        },
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(text, style: Theme.of(context).textTheme.bodySmall),
      ),
    );
  }
}

String _stripHtml(String html) {
  // TVMaze summaries contain simple HTML tags.
  return html
      .replaceAll(RegExp('<[^>]*>'), '')
      .replaceAll('&quot;', '"')
      .replaceAll('&amp;', '&')
      .trim();
}
