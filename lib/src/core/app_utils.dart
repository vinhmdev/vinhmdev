import 'dart:convert';

class AppUtils {
  AppUtils._();

  static String prettyJson(Map<String, dynamic> json) {
    return const JsonEncoder.withIndent('  ').convert(json);
  }

}