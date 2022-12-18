import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
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

  static String emailToUsername(String email) {
    return email.toLowerCase().replaceAll('@', 'ATSIGN').replaceAll('.', 'DOT');
  }

  static copyToClipboard(String? text, {BuildContext? context}) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (context != null) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Copied content: ```\n$text\n```'))); // todo lang
    }
  }

  static String getCurlReqeust(RequestOptions? requestInfo) {
    if (null == requestInfo) {
      return 'Nothing!'; // todo lang
    }
    try {
      String curl = 'curl --request ${requestInfo.method}';
      if ((requestInfo.data?.toString() ?? '').isNotEmpty) {
        curl += ' ${jsonEncode(requestInfo.data)}';
      }
      if (requestInfo.headers.isNotEmpty) {
        requestInfo.headers.forEach((e, v) {
          String vr;
          if (v is List) {
            vr = v.join(';');
          }
          vr = v.toString();
          curl += ' --header "$e: $vr"';
        });
      }
      curl += ' ${requestInfo.path}';
      return curl;
    } catch (_) {
      log('>>> $_', stackTrace: StackTrace.current);
    }
    return '<Nothing!>'; //todo lang
  }

}