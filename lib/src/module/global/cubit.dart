import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinhmdev/src/core/xdata.dart';

import 'state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(GlobalState().init()) {
    init();
  }

  Future<void> init() async {
    String localDefault = await XData.sharedPref.getString(XData.keyDefaultLocalization).catchError((_) => '');
    if (localDefault.isNotEmpty) {
      emit(GlobalState(locale: Locale(localDefault)));
    }
  }

  void setLocalization(Locale? locale) {
    XData.sharedPref.setString(XData.keyDefaultLocalization, locale?.languageCode ?? '');
    emit(state.copyWith(locale: locale));
  }

}
