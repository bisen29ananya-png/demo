part of 'movies_bloc.dart';

sealed class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object?> get props => [];
}

final class MoviesFetched extends MoviesEvent {
  const MoviesFetched();
}

final class MoviesRefreshed extends MoviesEvent {
  const MoviesRefreshed();
}
