import 'package:flutter/material.dart';

enum InitStatus {
  loading,
  success,
}

class GlobalState {

  InitStatus status;
  Locale? locale;
  ThemeMode themeMode;

  GlobalState({
    this.locale,
    this.themeMode = ThemeMode.light,
    this.status = InitStatus.loading,
  });

  GlobalState copyWith({
    Locale? locale,
    ThemeMode? themeMode,
    InitStatus? status,
  }) {
    return GlobalState(
      locale: locale ?? this.locale,
      themeMode: themeMode ?? this.themeMode,
      status: status ?? this.status,
    );
  }
}
