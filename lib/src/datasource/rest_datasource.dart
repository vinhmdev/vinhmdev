import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:vinhmdev/src/core/xdata.dart';
import 'package:vinhmdev/src/datasource/services/firebase_services.dart';

/// Datasource of Rest Api
class RestDatasource {
  final Dio _dio = Dio();

  RestDatasource(this._firebaseServices);
  Dio get dio {
    // (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
    //   client.badCertificateCallback = (cert, host, port) => true;
    //   return client;
    // };
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        handler.next(options);
      },
      onResponse: (e, handler) {
        handler.next(e);
      },
      onError: (e, handler) {
        handler.next(e);
      },
    ));
    return _dio;
  }

  /// Html basic call
  Future<Response> call({
    required String path,
    String method = 'GET',
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queries,
    dynamic body,
  }) {
    return dio.request(
      path,
      queryParameters: queries,
      data: body,
      options: Options(
        headers: headers,
        method: method,
      ),
    );
  }

  final FirebaseServices _firebaseServices;

  Future<dynamic> getAccount() {
    return _firebaseServices.getAccounts();
  }


}