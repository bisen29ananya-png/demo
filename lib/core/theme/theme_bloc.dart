import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:demo/core/design_system/app_colors.dart';
import 'package:demo/core/theme/theme_event.dart';
import 'package:demo/core/theme/theme_state.dart';

export 'theme_event.dart';
export 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
    : super(
        const ThemeState(
          mode: AppThemeMode.system,
          variant: ThemeVariant.classic,
        ),
      ) {
    on<ThemeModeChanged>((event, emit) {
      emit(state.copyWith(mode: event.mode));
    });
    on<ThemeVariantChanged>((event, emit) {
      emit(state.copyWith(variant: event.variant));
    });
  }
}
