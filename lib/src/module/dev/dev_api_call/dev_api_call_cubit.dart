import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:vinhmdev/src/datasource/rest_datasource.dart';
import 'package:vinhmdev/src/module/dev/dev_api_call/widget/dev_api_call_history_view.dart';
import 'package:vinhmdev/src/module/dev/dev_api_call/widget/dev_api_call_send_view.dart';

import 'dev_api_call_state.dart';

class DevApiCallCubit extends Cubit<DevApiCallState> {

  final RestDatasource _restDatasource;

  DevApiCallCubit(this._restDatasource) : super(DevApiCallState().init());

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
      emit(DevApiCallRequestState(response: response));
    }
    on DioError catch (dioError) {
      emit(DevApiCallRequestState(dioError: dioError));
    }
  }

}
