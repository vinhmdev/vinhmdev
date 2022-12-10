import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(GlobalState().init());

  void setLocalization(Locale? locale) {
    emit(state.copyWith(locale: locale));
  }

}
