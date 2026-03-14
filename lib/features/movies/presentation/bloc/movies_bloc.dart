import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:demo/features/movies/domain/entities/show.dart';
import 'package:demo/features/movies/domain/usecases/get_shows_page.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc({required this.getShowsPage}) : super(const MoviesState()) {
    on<MoviesFetched>(_onFetched);
    on<MoviesRefreshed>(_onRefreshed);
  }

  final GetShowsPageUseCase getShowsPage;

  Future<void> _onFetched(
    MoviesFetched event,
    Emitter<MoviesState> emit,
  ) async {
    if (state.status == MoviesStatus.loadingMore || state.hasReachedMax) return;

    final isInitial = state.status == MoviesStatus.initial;

    emit(
      state.copyWith(
        status: isInitial
            ? MoviesStatus.loadingInitial
            : MoviesStatus.loadingMore,
        errorMessage: null,
      ),
    );

    try {
      final nextPage = isInitial ? 0 : state.page + 1;
      final result = await getShowsPage(page: nextPage);

      final items = isInitial ? result : [...state.items, ...result];

      emit(
        state.copyWith(
          status: MoviesStatus.success,
          items: items,
          page: nextPage,
          hasReachedMax: result.isEmpty,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: MoviesStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onRefreshed(
    MoviesRefreshed event,
    Emitter<MoviesState> emit,
  ) async {
    emit(const MoviesState(status: MoviesStatus.loadingInitial));
    add(const MoviesFetched());
  }
}
