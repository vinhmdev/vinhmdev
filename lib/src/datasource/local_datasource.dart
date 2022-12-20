import 'dart:convert';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:vinhmdev/src/core/xdata.dart';
import 'package:vinhmdev/src/datasource/repositories/dev_api_call_configure.dart';

class LocalDatasource {
  Future<DevApiCallConfigure> setApiCallConfigure(DevApiCallConfigure configure) async {
    var isConfig = await XData.sharedPref.setString(
      XData.keyApiCallConfigure,
      jsonEncode(configure.toJson()),
    );
    if (!isConfig) {
      log('Configure Error', stackTrace: StackTrace.current);
      throw 'Configure Error';
    }
    return configure;
  }

  Future<DevApiCallConfigure> getApiCallConfigure() async {
    try {
      var configString = await XData.sharedPref.getString(XData.keyApiCallConfigure);
      DevApiCallConfigure configure = DevApiCallConfigure.fromJson(jsonDecode(configString));
      return configure;
    }
    catch (_) {
      log('>>> $_', stackTrace: StackTrace.current);
      return DevApiCallConfigure();
    }
  }
}