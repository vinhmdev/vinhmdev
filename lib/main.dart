import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:vinhmdev/l10n/generate/app_localizations.dart';
import 'package:vinhmdev/src/core/xdata.dart';
import 'package:vinhmdev/src/datasource/local_datasource.dart';
import 'package:vinhmdev/src/datasource/rest_datasource.dart';
import 'package:vinhmdev/src/datasource/services/firebase_services.dart';
import 'package:vinhmdev/src/module/authentication/authentication_view.dart';
import 'package:vinhmdev/src/module/dev/dev_api_call/dev_api_call_cubit.dart';
import 'package:vinhmdev/src/module/dev/dev_api_call/dev_api_call_view.dart';
import 'package:vinhmdev/src/module/dev/dev_api_call/widget/dev_api_call_setting_view.dart';
import 'package:vinhmdev/src/module/global/global_cubit.dart';
import 'package:vinhmdev/src/module/global/global_state.dart';
import 'package:vinhmdev/src/module/index/index_view.dart';
import 'package:vinhmdev/src/module/task_manager/task_manager_view.dart';

class _MyHttpOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = _MyHttpOverride();

  await XData.initConfig();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  Widget wrapRouter(Widget page) {
    return BlocBuilder<GlobalCubit, GlobalState>(
      buildWhen: (pre, cur) {
        return pre.status != cur.status || pre.loginStatus != cur.loginStatus;
      },
      builder: (context, state) {
        if (state.status == InitStatus.loading) {
          return const FlashPage();
        }
        if (XData.fau.currentUser != null) {
          return page;
        }
        return const AuthenticationPage();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => RestDatasource(FirebaseServices(XData.dio)),),
        RepositoryProvider(create: (context) => LocalDatasource(),),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => GlobalCubit(),),
          BlocProvider(create: (context) => DevApiCallCubit(RepositoryProvider.of<RestDatasource>(context),),),
        ],
        child: BlocBuilder<GlobalCubit, GlobalState>(
          buildWhen: (previous, current) {
             bool isBuild = previous.locale?.languageCode != current.locale?.languageCode;
             isBuild = isBuild || previous.themeMode.index != current.themeMode.index;
             return isBuild;
          },
          builder: (context, state) {
            return MaterialApp(
              title: 'Quản lý cá nhân',
              themeMode: state.themeMode,
              theme: ThemeData(
                primarySwatch: Colors.blue,
                primaryColor: Colors.blue,
                appBarTheme: const AppBarTheme(
                  elevation: 2,
                ),
                scaffoldBackgroundColor: Colors.grey.shade200,
                cardTheme: const CardTheme(
                  margin: EdgeInsets.zero,
                ),
                listTileTheme: const ListTileThemeData(
                  horizontalTitleGap: 8,
                  minLeadingWidth: 0,
                  textColor: Colors.blue,
                  iconColor: Colors.blue,
                )
              ),
              darkTheme: ThemeData.dark(),
              locale: state.locale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('vi'),
                Locale('en'),
              ],
              initialRoute: RouterName.index,
              navigatorObservers: [
                FirebaseAnalyticsObserver(analytics: XData.fa),
              ],
              routes: {
                RouterName.index: (context) {
                  return wrapRouter(IndexPage());
                },
                RouterName.taskManager: (context) {
                  return wrapRouter(const TaskManagerPage());
                },
                RouterName.devApiCall: (context) {
                  return wrapRouter(const DevApiCallPage());
                },
                RouterName.devApiCallSetting: (context) {
                  return wrapRouter(const DevApiCallSettingPage());
                },
              },
            );
          },
        ),
      ),
    );
  }
}

class FlashPage extends StatelessWidget {
  const FlashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Image.asset(
        'assets/images/error.jpeg',
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        fit: BoxFit.contain,
      ),
    );
  }

}