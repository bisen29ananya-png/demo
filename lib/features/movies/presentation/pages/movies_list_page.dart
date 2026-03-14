import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:demo/core/design_system/app_spacing.dart';
import 'package:demo/core/injection/service_locator.dart';
import 'package:demo/core/routing/app_router.dart';
import 'package:demo/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:demo/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:demo/features/movies/presentation/widgets/movie_card.dart';
import 'package:demo/features/movies/presentation/widgets/movies_list_shimmer.dart';
import 'package:demo/generated/l10n/app_localizations.dart';

@RoutePage()
class MoviesListPage extends StatefulWidget {
  const MoviesListPage({super.key});

  @override
  State<MoviesListPage> createState() => _MoviesListPageState();
}

class _MoviesListPageState extends State<MoviesListPage> {
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final threshold = _controller.position.maxScrollExtent * 0.9;
    if (_controller.position.pixels >= threshold) {
      context.read<MoviesBloc>().add(const MoviesFetched());
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocProvider(
      create: (_) => getIt<MoviesBloc>()..add(const MoviesFetched()),
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.moviesTitle)),
        body: BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            if (state.status == MoviesStatus.loadingInitial ||
                state.status == MoviesStatus.initial) {
              return const MoviesListShimmer();
            }

            if (state.status == MoviesStatus.failure && state.items.isEmpty) {
              return _ErrorState(
                message: state.errorMessage ?? l10n.errorGeneric,
                onRetry: () =>
                    context.read<MoviesBloc>().add(const MoviesRefreshed()),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<MoviesBloc>().add(const MoviesRefreshed());
              },
              child: ListView.separated(
                controller: _controller,
                padding: const EdgeInsets.only(
                  left: AppSpacing.sm,
                  right: AppSpacing.sm,
                  bottom: AppSpacing.xxl,
                ),
                itemCount: state.items.length + 1,
                separatorBuilder: (_, _) =>
                    const SizedBox(height: AppSpacing.sm),
                itemBuilder: (context, index) {
                  if (index >= state.items.length) {
                    if (state.hasReachedMax) {
                      return Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: Center(
                          child: Text(
                            l10n.noMoreResults,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      );
                    }

                    if (state.status == MoviesStatus.loadingMore) {
                      return const Padding(
                        padding: EdgeInsets.all(AppSpacing.lg),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    return const SizedBox.shrink();
                  }

                  final show = state.items[index];
                  final favorites = context.watch<FavoritesBloc>().state;
                  final isFavorite = favorites.ids.contains(show.id);

                  return MovieCard(
                    show: show,
                    isFavorite: isFavorite,
                    onTap: () {
                      context.router.push(MovieDetailsRoute(id: show.id));
                    },
                    onToggleFavorite: () {
                      context.read<FavoritesBloc>().add(FavoriteToggled(show));
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.lg),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(l10n.retry),
            ),
          ],
        ),
      ),
    );
  }
}
