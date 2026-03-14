import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:demo/core/design_system/app_colors.dart';
import 'package:demo/core/design_system/app_spacing.dart';
import 'package:demo/core/localization/locale_bloc.dart';
import 'package:demo/core/theme/theme_bloc.dart';
import 'package:demo/generated/l10n/app_localizations.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final themeBloc = context.watch<ThemeBloc>();
    final localeBloc = context.watch<LocaleBloc>();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(l10n.theme, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          _ThemeModePicker(selected: themeBloc.state.mode),
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.designSystemVariant,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          _VariantPicker(selected: themeBloc.state.variant),
          const SizedBox(height: AppSpacing.xl),
          Text(l10n.language, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          _LanguagePicker(selected: localeBloc.state.locale?.languageCode),
        ],
      ),
    );
  }
}

class _ThemeModePicker extends StatelessWidget {
  const _ThemeModePicker({required this.selected});

  final AppThemeMode selected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final bloc = context.read<ThemeBloc>();

    return Card(
      child: RadioGroup<AppThemeMode>(
        groupValue: selected,
        onChanged: (v) {
          if (v == null) return;
          bloc.add(ThemeModeChanged(v));
        },
        child: Column(
          children: [
            RadioListTile<AppThemeMode>(
              value: AppThemeMode.system,
              title: Text(l10n.themeSystem),
            ),
            RadioListTile<AppThemeMode>(
              value: AppThemeMode.light,
              title: Text(l10n.themeLight),
            ),
            RadioListTile<AppThemeMode>(
              value: AppThemeMode.dark,
              title: Text(l10n.themeDark),
            ),
          ],
        ),
      ),
    );
  }
}

class _VariantPicker extends StatelessWidget {
  const _VariantPicker({required this.selected});

  final ThemeVariant selected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final bloc = context.read<ThemeBloc>();

    return Card(
      child: RadioGroup<ThemeVariant>(
        groupValue: selected,
        onChanged: (v) {
          if (v == null) return;
          bloc.add(ThemeVariantChanged(v));
        },
        child: Column(
          children: [
            RadioListTile<ThemeVariant>(
              value: ThemeVariant.classic,
              title: Text(l10n.variantClassic),
            ),
            RadioListTile<ThemeVariant>(
              value: ThemeVariant.ocean,
              title: Text(l10n.variantOcean),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguagePicker extends StatelessWidget {
  const _LanguagePicker({required this.selected});

  final String? selected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final bloc = context.read<LocaleBloc>();

    return Card(
      child: RadioGroup<String?>(
        groupValue: selected,
        onChanged: (v) {
          if (v == null) {
            bloc.add(const LocaleFollowSystemRequested());
          } else {
            bloc.add(LocaleChanged(Locale(v)));
          }
        },
        child: Column(
          children: [
            RadioListTile<String?>(value: null, title: Text(l10n.themeSystem)),
            RadioListTile<String?>(
              value: 'en',
              title: Text(l10n.languageEnglish),
            ),
            RadioListTile<String?>(
              value: 'ar',
              title: Text(l10n.languageArabic),
            ),
          ],
        ),
      ),
    );
  }
}
