import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:demo/core/localization/locale_event.dart';
import 'package:demo/core/localization/locale_state.dart';

export 'locale_event.dart';
export 'locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(const LocaleState(locale: null)) {
    on<LocaleFollowSystemRequested>((event, emit) {
      emit(const LocaleState(locale: null));
    });

    on<LocaleChanged>((event, emit) {
      emit(LocaleState(locale: event.locale));
    });
  }
}
