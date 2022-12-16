import 'dart:convert';

import 'package:flutter/material.dart';

class AppUtils {
  AppUtils._();

  static String prettyJson(Map<String, dynamic> json) {
    return const JsonEncoder.withIndent('  ').convert(json);
  }

  static void unfocusKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

}