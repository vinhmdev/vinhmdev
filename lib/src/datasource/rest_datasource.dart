import 'package:dio/dio.dart';
import 'package:vinhmdev/src/core/xdata.dart';

class RestDatasource {

  final Dio _dio = Dio();

  Dio get dio {
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
}