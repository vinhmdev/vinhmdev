import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:vinhmdev/src/core/xdata.dart';

part 'firebase_services.g.dart';

/// Rest Api of Firebase Realtime Database
@RestApi(baseUrl: XData.firebaseDatabaseUrl)
abstract class FirebaseServices {
  factory FirebaseServices(Dio dio , {String baseUrl}) = _FirebaseServices;

  @GET('/accounts.json') // /accounts/mvinhle22ATSIGNgmailDOTcom/configure.json
  Future<dynamic> getAccounts();

  @POST('/accounts.json')
  Future<dynamic> addAccounts();

}