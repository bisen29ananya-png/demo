import 'package:demo/core/theme/theme_state.dart';
import 'package:equatable/equatable.dart';

import 'package:demo/core/design_system/app_colors.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

final class ThemeModeChanged extends ThemeEvent {
  const ThemeModeChanged(this.mode);

  final AppThemeMode mode;

  @override
  List<Object?> get props => [mode];
}

final class ThemeVariantChanged extends ThemeEvent {
  const ThemeVariantChanged(this.variant);

  final ThemeVariant variant;

  @override
  List<Object?> get props => [variant];
}
