import 'package:flutter/material.dart';

class SettingState {

  SettingState({
    this.localeSubmit,
    this.themeMode,
  });

  Locale? localeSubmit;
  ThemeMode? themeMode;

  SettingState copyWith({
    Locale? localeSubmit,
    ThemeMode? themeMode,
  }) {
    return SettingState(
      localeSubmit: localeSubmit ?? this.localeSubmit,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
