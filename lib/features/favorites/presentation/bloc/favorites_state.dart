import 'package:equatable/equatable.dart';

import 'package:demo/features/movies/domain/entities/show.dart';

class FavoritesState extends Equatable {
  const FavoritesState({this.byId = const <int, Show>{}});

  final Map<int, Show> byId;

  Set<int> get ids => byId.keys.toSet();

  List<Show> get items => byId.values.toList(growable: false);

  @override
  List<Object?> get props => [byId];
}
