import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:demo/core/design_system/app_spacing.dart';

class MoviesListShimmer extends StatelessWidget {
  const MoviesListShimmer({super.key, this.itemCount = 8});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final baseColor = Theme.of(context).colorScheme.surfaceContainerHighest;
    final highlightColor = Theme.of(context).colorScheme.surface;

    return ListView.separated(
      itemCount: itemCount,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                children: [
                  Container(
                    width: 72,
                    height: 100,
                    decoration: BoxDecoration(
                      color: baseColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.lg),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 14,
                          width: double.infinity,
                          color: baseColor,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Container(height: 12, width: 220, color: baseColor),
                        const SizedBox(height: AppSpacing.lg),
                        Container(height: 12, width: 80, color: baseColor),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
