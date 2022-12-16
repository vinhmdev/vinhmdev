import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
  DevApiCallRequestState({this.response, this.dioError});
}

class DevApiCallHistoryState extends DevApiCallState {

}