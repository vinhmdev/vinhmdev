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

  final bool isRqstShowCurlInfo;

  final bool isRspShowHeadersInfo;
  final bool isRspShowBodyInfo;
  final bool isRspShowRequestInfo;

  final bool isErShowHeadersInfo;
  final bool isErShowBodyInfo;
  final bool isErShowRequestInfo;


  DevApiCallRequestState({
    this.response,
    this.dioError,
    this.isRqstShowCurlInfo = true,
    this.isRspShowHeadersInfo = true,
    this.isRspShowBodyInfo = true,
    this.isRspShowRequestInfo = true,
    this.isErShowHeadersInfo = true,
    this.isErShowBodyInfo = true,
    this.isErShowRequestInfo = true,
    super.tabIndex,
    super.tabView,
  });


  DevApiCallRequestState copyDevApiCallRequestStateWith({
    Response? response,
    DioError? dioError,
    bool? isRqstShowCurlInfo,
    bool? isRspShowHeadersInfo,
    bool? isRspShowBodyInfo,
    bool? isRspShowRequestInfo,
    bool? isErShowHeadersInfo,
    bool? isErShowBodyInfo,
    bool? isErShowRequestInfo,
  }) {
    return DevApiCallRequestState(
      response: response ?? this.response,
      dioError: dioError ?? this.dioError,
      isRqstShowCurlInfo: isRqstShowCurlInfo ?? this.isRqstShowCurlInfo,
      isRspShowHeadersInfo: isRspShowHeadersInfo ?? this.isRspShowHeadersInfo,
      isRspShowBodyInfo: isRspShowBodyInfo ?? this.isRspShowBodyInfo,
      isRspShowRequestInfo: isRspShowRequestInfo ?? this.isRspShowRequestInfo,
      isErShowHeadersInfo: isErShowHeadersInfo ?? this.isErShowHeadersInfo,
      isErShowBodyInfo: isErShowBodyInfo ?? this.isErShowBodyInfo,
      isErShowRequestInfo: isErShowRequestInfo ?? this.isErShowRequestInfo,
      tabIndex: super.tabIndex,
      tabView: super.tabView,
    );
  }
}

class DevApiCallHistoryState extends DevApiCallState {

}