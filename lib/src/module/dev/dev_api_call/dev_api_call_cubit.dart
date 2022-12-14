import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:vinhmdev/src/core/app_utils.dart';
import 'package:vinhmdev/src/core/xdata.dart';
import 'package:vinhmdev/src/datasource/repositories/dev_api_call_configure.dart';
import 'package:vinhmdev/src/datasource/rest_datasource.dart';
import 'package:vinhmdev/src/module/dev/dev_api_call/widget/dev_api_call_history_view.dart';
import 'package:vinhmdev/src/module/dev/dev_api_call/widget/dev_api_call_send_view.dart';

import 'dev_api_call_state.dart';

class DevApiCallCubit extends Cubit<DevApiCallState> {

  final RestDatasource _restDatasource;

  DatabaseReference get ref {
    var email = XData.fau.currentUser?.email ?? XData.fau.currentUser?.uid ?? 'UserIsNull';
    return XData.fdb.ref('/accounts/${AppUtils.emailToUsername(email)}/dev_api_call/configure');
  }

  DevApiCallCubit(this._restDatasource) : super(DevApiCallState().init());

  DevApiCallConfigure? _configure;
  Future<DevApiCallConfigure> getConfigure () async {
    if (null == _configure) {
      var snapshot = await ref.get();
      try {
        _configure = DevApiCallConfigure.fromJson(jsonDecode(jsonEncode(snapshot.value)));
      }
      catch (error) {
        log('>>> $error', error: error);
        _configure = DevApiCallConfigure();
      }
    }
    return _configure!;
  }

  void changeTab(int? tabIndex) {
    tabIndex ??= 0;
    Widget page;
    switch(tabIndex) {
      case 1:
        page = const DevApiCallHistoryPage();
        break;
      case 0:
      default:
        page = const DevApiCallSendPage();
    }
    emit(DevApiCallState(
      tabIndex: tabIndex,
      tabView: page,
    ));
  }

  Future<void> sendRequest({
    required Uri uri,
    String method = 'GET',
    Map<String, dynamic>? headers,
    dynamic body,
  }) async {
    var path = uri.toString();
    if (method.trim().isEmpty) {
      method = 'GET';
    }
    try {
      Response response = await _restDatasource.call(
        path: path,
        method: method,
        headers: headers,
        body: body,
      );
      emit(DevApiCallRequestState(
        response: response,
        configure: _configure ?? await getConfigure(),
      ));
    }
    on DioError catch (dioError) {
      emit(DevApiCallRequestState(
        dioError: dioError,
        configure: _configure ?? await getConfigure(),
      ));
    }
  }

  Future<void> updateConfigure(DevApiCallConfigure configure, [bool isSynchronous = true]) async {
    if (isSynchronous) {
      await ref.set(configure.toJson());
    }
    _configure = configure;
    if (state is DevApiCallRequestState) {
      emit((state as DevApiCallRequestState).copyDevApiCallRequestStateWith(
        configure: configure,
      ));
    }
    else {
      emit(DevApiCallRequestState(
        configure: configure,
      ));
    }
  }

  Future<void> clearCacheConfigure() async {
    _configure = null;
    if (state is DevApiCallRequestState) {
      emit((state as DevApiCallRequestState).copyDevApiCallRequestStateWith(
        configure: await getConfigure(),
      ));
    }
    else {
      emit(DevApiCallRequestState(
        configure: await getConfigure(),
      ));
    }
  }

}
