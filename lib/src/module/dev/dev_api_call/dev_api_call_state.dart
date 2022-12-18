import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:vinhmdev/src/datasource/repository/dev_api_call_configure.dart';
import 'package:vinhmdev/src/module/dev/dev_api_call/widget/dev_api_call_send_view.dart';

class DevApiCallState {

  final int tabIndex;

  final Widget tabView;

  DevApiCallState({
    this.tabIndex = 0,
    this.tabView = const DevApiCallSendPage(),
  });

  DevApiCallState init() {
    return DevApiCallState();
  }

  DevApiCallState copyWith({
    int? tabIndex,
    Widget? tabView,
  }) {
    return DevApiCallState(
      tabIndex: tabIndex ?? this.tabIndex,
      tabView: tabView ?? this.tabView,
    );
  }

}

class DevApiCallRequestState extends DevApiCallState {
  final Response? response;
  final DioError? dioError;

  final DevApiCallConfigure configure;

  DevApiCallRequestState({
    this.response,
    this.dioError,
    required this.configure,
    super.tabIndex,
    super.tabView,
  });


  DevApiCallRequestState copyDevApiCallRequestStateWith({
    Response? response,
    DioError? dioError,
    DevApiCallConfigure? configure,
  }) {
    return DevApiCallRequestState(
      response: response ?? this.response,
      dioError: dioError ?? this.dioError,
      configure: configure ?? this.configure,
      tabIndex: super.tabIndex,
      tabView: super.tabView,
    );
  }
}

class DevApiCallHistoryState extends DevApiCallState {

}