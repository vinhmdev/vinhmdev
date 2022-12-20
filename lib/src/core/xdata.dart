import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:vinhmdev/firebase_options.dart';

class XData {
  XData._();

  static const String keyDefaultLocalization = 'defaultLocalization';
  static const String keyDefautlThemeMode = 'defautlThemeMode';
  static const String keyTopicSubcribeNotification = 'notifications';

  static const String keyApiCallConfigure = 'apiCallConfigure';

  static const String firebaseDatabaseUrl = 'https://vinhmdev-default-rtdb.firebaseio.com';

  static const List<String> devApiCallMethodRequest = ['GET', 'POST', 'PUT', 'DELETE', 'PATH'];
  static const Map<String, String?> devApiCallHeaderRequest = {
    'enctype': 'multipart/form-data',
    'Authorization': null,
  };

  static Dio? _dio;
  static Dio get dio {
    if (_dio == null) {
      var newDio = Dio();
      // TODO: configure dio in here
      _dio = newDio;
    }
    return _dio!;
  }
  static EncryptedSharedPreferences? _sharedPref;
  static EncryptedSharedPreferences get sharedPref {
    _sharedPref ??= EncryptedSharedPreferences(
      mode: AESMode.sic,
      randomKeyKey: 'vinhmdevkeykey',
      randomKeyListKey: 'vinhmdevlistkey',
    );
    return _sharedPref!;
  }
  static Future<void> initConfig() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      try {
        await fm.subscribeToTopic(keyTopicSubcribeNotification); // don't support web sdk
      }
      catch (_) {
        log('>>> fm.subscribeToTopic: don\'t support web sdk \n>>> $_');
      }

      FirebaseMessaging.onMessage.listen((event) {
        log('>>> onMessage.listen: >>> ${event.data} ${event.notification?.title} ${event.notification?.body}');
      });
    } catch (_) {
      log('>>> $_', stackTrace: StackTrace.fromString(_.toString()));
      if (kDebugMode) {
        rethrow;
      }
    }
    try {
      print('>>> fm.getToken() ${await fm.getToken()}');
    } catch (_) {
      print('>>> error: >>> $_');
    }
  }

  static FirebaseAnalytics get fa => FirebaseAnalytics.instance;
  static FirebaseDatabase get fdb => (FirebaseDatabase.instance..databaseURL = firebaseDatabaseUrl);
  static FirebaseMessaging get fm => FirebaseMessaging.instance;

}

class RouterName {
  RouterName._();
  static const String index = '/';
  static const String home = '${index}home/';
  static const String setting = '${index}setting/';
  static const String taskManager = '${index}task-manager/';
  static const String devApiCall = '${index}dev-api-call/';
  static const String devApiCallSetting = '${devApiCall}dev-api-call-setting/';
}