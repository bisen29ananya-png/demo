import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

sealed class LocaleEvent extends Equatable {
  const LocaleEvent();

  @override
  List<Object?> get props => [];
}

final class LocaleFollowSystemRequested extends LocaleEvent {
  const LocaleFollowSystemRequested();
}

final class LocaleChanged extends LocaleEvent {
  const LocaleChanged(this.locale);

  final Locale locale;

  @override
  List<Object?> get props => [locale.languageCode, locale.countryCode];
}
