import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:demo/features/favorites/presentation/bloc/favorites_event.dart';
import 'package:demo/features/favorites/presentation/bloc/favorites_state.dart';
import 'package:demo/features/movies/domain/entities/show.dart';

export 'favorites_event.dart';
export 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(const FavoritesState()) {
    on<FavoriteToggled>((event, emit) {
      final next = Map<int, Show>.from(state.byId);
      if (next.containsKey(event.show.id)) {
        next.remove(event.show.id);
      } else {
        next[event.show.id] = event.show;
      }
      emit(FavoritesState(byId: next));
    });

    on<FavoritesCleared>((event, emit) {
      emit(const FavoritesState());
    });
  }
}
