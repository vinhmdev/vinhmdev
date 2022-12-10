import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinhmdev/l10n/generate/app_localizations.dart';
import 'package:vinhmdev/src/core/xdata.dart';
import 'package:vinhmdev/src/module/global/cubit.dart';
import 'package:vinhmdev/src/module/setting/view.dart';

import '../home/view.dart';
import 'cubit.dart';
import 'state.dart';

class IndexPage extends StatelessWidget {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  IndexPage({super.key});

  void switchDrawer(BuildContext context) {
    if (Scaffold.of(context).isDrawerOpen) {
      Scaffold.of(context).closeDrawer();
    }
    else {
      Scaffold.of(context).openDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => IndexCubit(),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    // final cubit = BlocProvider.of<IndexCubit>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Index Screen'),
          leading: Builder(
            builder: (context) {
              return IconButton(
                onPressed: () => switchDrawer(context),
                icon: const Icon(Icons.menu),
              );
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                if (AppLocalizations.of(context).localeName == 'vi') {
                  BlocProvider.of<GlobalCubit>(context).setLocalization(const Locale('en'));
                }
                else {
                  BlocProvider.of<GlobalCubit>(context).setLocalization(const Locale('vi'));
                }
              },
              icon: const Icon(Icons.language),
            ),
          ],
      ),
      drawer: DrawerIndexPage(navigatorKey: navigatorKey),
      body: Navigator(
        key: navigatorKey,
        initialRoute: RouterName.home,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case RouterName.home:
              return MaterialPageRoute(
                builder: (context) => const HomePage(),
              );
            case RouterName.setting:
              return MaterialPageRoute(
                builder: (context) => const SettingPage(),
              );
            default:
              return MaterialPageRoute(
                builder: (context) => const HomePage(),
              );
          }
        },
      ),
    );
  }
}

class DrawerIndexPage extends StatelessWidget {
  const DrawerIndexPage({super.key, required this.navigatorKey});

  final GlobalKey<NavigatorState> navigatorKey;

  void gotoPage(BuildContext context, String routerName) {
    final cubit = BlocProvider.of<IndexCubit>(context);
    navigatorKey.currentState!.pushNamed(routerName);

    if (Scaffold.of(context).isDrawerOpen) {
      Scaffold.of(context).closeDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);

    return Drawer(
      child: ListView(
        children: [
          TextButton(
            onPressed: () => gotoPage(context, RouterName.home),
            child: Text(
              lang.homePage,
            ),
          ),
          TextButton(
            onPressed: () => gotoPage(context, RouterName.setting),
            child: Text(
              lang.settingPage,
            ),
          ),
        ],
      ),
    );
  }

}

