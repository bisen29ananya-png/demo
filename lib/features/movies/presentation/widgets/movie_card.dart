import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:demo/core/design_system/app_spacing.dart';
import 'package:demo/features/movies/domain/entities/show.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    super.key,
    required this.show,
    required this.isFavorite,
    required this.onTap,
    required this.onToggleFavorite,
  });

  final Show show;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Poster(url: show.imageMedium),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            show.name,
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          onPressed: onToggleFavorite,
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? scheme.primary : null,
                          ),
                          tooltip: 'Favorite',
                        ),
                      ],
                    ),
                    if (show.genres.isNotEmpty)
                      Text(
                        show.genres.take(3).join(' • '),
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 18),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          (show.rating?.toStringAsFixed(1)) ?? '—',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Poster extends StatelessWidget {
  const _Poster({required this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.surfaceContainerHighest;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 72,
        height: 100,
        child: url == null
            ? ColoredBox(color: color)
            : CachedNetworkImage(
                imageUrl: url!,
                fit: BoxFit.cover,
                placeholder: (_, __) => ColoredBox(color: color),
                errorWidget: (_, __, ___) => ColoredBox(color: color),
              ),
      ),
    );
  }
}
