import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  static copyToClipboard(String? text, {BuildContext? context}) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Copied content: ```\n$text\n```'))); // todo lang
    }
  }

}