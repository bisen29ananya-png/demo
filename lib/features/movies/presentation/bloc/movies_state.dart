part of 'movies_bloc.dart';

enum MoviesStatus { initial, loadingInitial, loadingMore, success, failure }

class MoviesState extends Equatable {
  const MoviesState({
    this.status = MoviesStatus.initial,
    this.items = const <Show>[],
    this.page = -1,
    this.hasReachedMax = false,
    this.errorMessage,
  });

  final MoviesStatus status;
  final List<Show> items;
  final int page;
  final bool hasReachedMax;
  final String? errorMessage;

  MoviesState copyWith({
    MoviesStatus? status,
    List<Show>? items,
    int? page,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    return MoviesState(
      status: status ?? this.status,
      items: items ?? this.items,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, items, page, hasReachedMax, errorMessage];
}
