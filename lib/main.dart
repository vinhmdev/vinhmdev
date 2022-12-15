import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:vinhmdev/l10n/generate/app_localizations.dart';
import 'package:vinhmdev/src/core/xdata.dart';
import 'package:vinhmdev/src/module/dev/dev_api_call/dev_api_call_view.dart';
import 'package:vinhmdev/src/module/global/global_cubit.dart';
import 'package:vinhmdev/src/module/global/global_state.dart';
import 'package:vinhmdev/src/module/index/index_view.dart';
import 'package:vinhmdev/src/module/task_manager/task_manager_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await XData.initConfig();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  Widget wrapRouter(Widget page) {
    return BlocBuilder<GlobalCubit, GlobalState>(
      buildWhen: (pre, cur) {
        return pre.status != cur.status;
      },
      builder: (context, state) {
        return Stack(
          children: [
            page,
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Visibility(
                visible: state.status == InitStatus.loading,
                child: const FlashPage(),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('>>> MyApp Rebuild');
    return BlocProvider(
      create: (context) => GlobalCubit(),
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
              primarySwatch: Colors.red,
              primaryColor: Colors.red,
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
                textColor: Colors.red,
                iconColor: Colors.red
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
            },
          );
        },
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