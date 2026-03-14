import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class LocaleState extends Equatable {
  const LocaleState({required this.locale});

  /// null means "follow device".
  final Locale? locale;

  @override
  List<Object?> get props => [locale?.languageCode, locale?.countryCode];
}
