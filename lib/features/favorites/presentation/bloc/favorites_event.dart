import 'package:equatable/equatable.dart';

import 'package:demo/features/movies/domain/entities/show.dart';

sealed class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

final class FavoriteToggled extends FavoritesEvent {
  const FavoriteToggled(this.show);

  final Show show;

  @override
  List<Object?> get props => [show];
}

final class FavoritesCleared extends FavoritesEvent {
  const FavoritesCleared();
}
