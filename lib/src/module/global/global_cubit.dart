import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinhmdev/src/core/xdata.dart';

import 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(GlobalState()) {
    init();
  }

  Future<void> init() async {
    String localeDefault = await XData.sharedPref.getString(XData.keyDefaultLocalization).catchError((_) => '');
    String themeIdDefault = await XData.sharedPref.getString(XData.keyDefautlThemeMode).catchError((_) => '');
    GlobalState defaultState = GlobalState(
      status: InitStatus.success,
      loginStatus: _isSignin() ? InitStatus.success : InitStatus.loading,
    );
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

  void refreshSigin() {
    XData.fa.setUserId(
      id: XData.fau.currentUser?.uid,
    );
    if (_isSignin()) {
      <String,String?>{
        'displayName': XData.fau.currentUser?.displayName,
        'email': XData.fau.currentUser?.email,
        'phoneNumber': XData.fau.currentUser?.phoneNumber,
        'photoURL': XData.fau.currentUser?.photoURL,
        'uid': XData.fau.currentUser?.uid,
        'tenantId': XData.fau.currentUser?.tenantId,
        'emailVerified': (XData.fau.currentUser?.emailVerified ?? false) ? 'true' : 'false',
        'isAnonymous': (XData.fau.currentUser?.isAnonymous ?? false) ? 'true' : 'false',
      }.forEach((key, value) {
        XData.fa.setUserProperty(name: key, value: value);
      });
      emit(state.copyWith(loginStatus: InitStatus.success,));
    }
    else {
      emit(state.copyWith(loginStatus: InitStatus.loading,));
    }
  }

  bool _isSignin() {
    var user = XData.fau.currentUser;
    return user != null;
  }

}
