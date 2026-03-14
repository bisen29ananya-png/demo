import 'package:flutter/material.dart';

enum ThemeVariant { classic, ocean }

class AppColors {
  const AppColors({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.surface,
    required this.error,
  });

  final Color primary;
  final Color secondary;
  final Color background;
  final Color surface;
  final Color error;

  static AppColors forVariant(ThemeVariant variant, Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    switch (variant) {
      case ThemeVariant.classic:
        return AppColors(
          primary: isDark ? const Color(0xFFB39DDB) : const Color(0xFF5E35B1),
          secondary: isDark ? const Color(0xFF80CBC4) : const Color(0xFF00796B),
          background: isDark
              ? const Color(0xFF0E0E10)
              : const Color(0xFFF7F7FB),
          surface: isDark ? const Color(0xFF1A1A1F) : Colors.white,
          error: const Color(0xFFB00020),
        );
      case ThemeVariant.ocean:
        return AppColors(
          primary: isDark ? const Color(0xFF8AB4F8) : const Color(0xFF0D47A1),
          secondary: isDark ? const Color(0xFF7AE0FF) : const Color(0xFF00838F),
          background: isDark
              ? const Color(0xFF0B1320)
              : const Color(0xFFF1F6FF),
          surface: isDark ? const Color(0xFF101C2E) : Colors.white,
          error: const Color(0xFFD32F2F),
        );
    }
  }
}
