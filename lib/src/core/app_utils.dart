import 'dart:convert';

import 'package:flutter/material.dart';

class AppUtils {
  AppUtils._();

  static String prettyJson(dynamic json) {
    try {
      return const JsonEncoder.withIndent('  ').convert(json);
    } catch (_) {
      return json.toString();
    }
  }

  static void unfocusKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

}