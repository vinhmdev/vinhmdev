import 'package:dio/dio.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class XData {
  XData._();

  static final String keyDefaultLocalization = 'defaultLocalization';

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
}

class RouterName {
  RouterName._();
  static const String index = '/';
  static const String home = '${index}home/';
  static const String setting = '${index}setting/';
}