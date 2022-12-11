import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinhmdev/src/core/xdata.dart';

import 'state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(GlobalState()) {
    init();
  }

  Future<void> init() async {
    String localeDefault = await XData.sharedPref.getString(XData.keyDefaultLocalization).catchError((_) => '');
    String themeIdDefault = await XData.sharedPref.getString(XData.keyDefautlThemeMode).catchError((_) => '');
    GlobalState defaultState = GlobalState(status: InitStatus.success);
    if (localeDefault.isNotEmpty) {
      defaultState.locale = Locale(localeDefault);
    }
    if (themeIdDefault.isNotEmpty) {
      if (themeIdDefault == ThemeMode.system.index.toString()) {
        defaultState.themeMode = ThemeMode.system;
      }
      else if (themeIdDefault == ThemeMode.light.index.toString()) {
        defaultState.themeMode = ThemeMode.light;
      }
      else if (themeIdDefault == ThemeMode.dark.index.toString()) {
        defaultState.themeMode = ThemeMode.dark;
      }
    }
    emit(defaultState);
  }

  void setConfig({Locale? locale, ThemeMode? themeMode}) {
    ThemeMode newTheme = themeMode ?? state.themeMode;
    XData.sharedPref.setString(XData.keyDefaultLocalization, locale?.languageCode ?? '');
    XData.sharedPref.setString(XData.keyDefautlThemeMode, newTheme.index.toString());

    emit(state.copyWith(
      themeMode: newTheme,
      locale: locale,
    ));
  }

}
