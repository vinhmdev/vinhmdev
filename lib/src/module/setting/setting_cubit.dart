import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingState());

  void localeSelected (Locale? locale) {
    emit(state.copyWith(
      localeSubmit: locale,
    ));
  }

  void themeSelected (ThemeMode themeMode) {
    emit(state.copyWith(
      themeMode: themeMode,
    ));
  }

}
