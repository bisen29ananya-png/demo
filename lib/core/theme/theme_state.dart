import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:demo/core/design_system/app_colors.dart';
import 'package:demo/core/design_system/app_theme.dart';

enum AppThemeMode { system, light, dark }

class ThemeState extends Equatable {
  const ThemeState({required this.mode, required this.variant});

  final AppThemeMode mode;
  final ThemeVariant variant;

  ThemeMode get themeMode {
    switch (mode) {
      case AppThemeMode.system:
        return ThemeMode.system;
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
    }
  }

  ThemeData get lightTheme =>
      AppTheme.build(variant: variant, brightness: Brightness.light);

  ThemeData get darkTheme =>
      AppTheme.build(variant: variant, brightness: Brightness.dark);

  ThemeState copyWith({AppThemeMode? mode, ThemeVariant? variant}) {
    return ThemeState(
      mode: mode ?? this.mode,
      variant: variant ?? this.variant,
    );
  }

  @override
  List<Object?> get props => [mode, variant];
}
