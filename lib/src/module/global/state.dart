import 'package:flutter/material.dart';

class GlobalState {

  Locale? locale;

  GlobalState({
    this.locale,
  });

  GlobalState init() {
    return GlobalState();
  }

  GlobalState copyWith({
    Locale? locale,
  }) {
    return GlobalState(
      locale: locale ?? this.locale,
    );
  }

  GlobalState clone() {
    return GlobalState();
  }
}
