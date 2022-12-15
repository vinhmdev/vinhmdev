import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinhmdev/l10n/generate/app_localizations.dart';
import 'package:vinhmdev/src/core/xdata.dart';
import 'package:vinhmdev/src/module/setting/setting_view.dart';

import '../home/global_view.dart';
import 'index_cubit.dart';
import 'index_state.dart';

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

  String routerToNamePage(BuildContext context, String path) {
    final lang = AppLocalizations.of(context);
    switch (path) {
      case RouterName.home:
        return lang.homePage;
      case RouterName.setting:
        return lang.settingPage;
    }
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => IndexCubit(),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final cubit = BlocProvider.of<IndexCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<IndexCubit, IndexState>(
          builder: (context, state) {
            var namePage = routerToNamePage(context, state.routerPage);
            return Text(namePage);
          },
        ),
      ),
      drawer: DrawerIndexPage(navigatorKey: navigatorKey),
      body: Navigator(
        key: navigatorKey,
        initialRoute: RouterName.home,
        onGenerateRoute: (settings) {
          Widget? page;
          switch (settings.name) {
            case RouterName.home:
              page = const HomePage();
              break;
            case RouterName.setting:
              page = const SettingPage();
              break;
          }
          if (page != null) {
            cubit.setRouter(settings.name!);
            return MaterialPageRoute(
              builder: (_) => page!,
              settings: settings,
            );
          }
          return null;
        },
      ),
    );
  }
}

class DrawerIndexPage extends StatelessWidget {
  const DrawerIndexPage({super.key, required this.navigatorKey});

  final GlobalKey<NavigatorState> navigatorKey;

  void gotoPage(BuildContext context, String routerName, {bool usingRoot = false}) {
    final cubit = BlocProvider.of<IndexCubit>(context);
    closeDrawer(context);
    if (!usingRoot) {
      cubit.setRouter(routerName);
      navigatorKey.currentState!.pushNamedAndRemoveUntil(routerName, (route) => false,);
    }
    else {
      Navigator.of(context).pushNamed(routerName);
    }
  }

  void closeDrawer(BuildContext context) {
    if (Scaffold.of(context).isDrawerOpen) {
      Scaffold.of(context).closeDrawer();
    }
  }

  List<Map<String, dynamic>> drawerAction(BuildContext context) {
    var lang = AppLocalizations.of(context);
    return [
      {
        'prefixIcon': const Icon(Icons.home),
        'label': lang.homePage,
        'action': () => gotoPage(context, RouterName.home),
        'headLine': true,
      },
      {
        'prefixIcon': const Icon(Icons.settings),
        'label': lang.settingPage,
        'action': () => gotoPage(context, RouterName.setting),
      },
      {
        'prefixIcon': const Icon(Icons.task),
        'label': lang.taskManagerPage,
        'action': () => gotoPage(context, RouterName.taskManager, usingRoot: true),
        'headLine': true,
        'suffixIcon': const Icon(Icons.outbond_outlined),
      },
      {
        'prefixIcon': const Icon(Icons.task),
        'label': lang.devApiCallPage,
        'action': () => gotoPage(context, RouterName.devApiCall, usingRoot: true),
        'headLine': true,
        'suffixIcon': const Icon(Icons.outbond_outlined),
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context);
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            onTap: () => closeDrawer(context),
            title: Text(
              lang.appAuthor,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: IgnorePointer(
              ignoring: true,
              child: ElevatedButton.icon(
                  onPressed: () => closeDrawer(context),
                  icon: const Icon(Icons.arrow_back),
                  label: Text(lang.indexBack),
              ),
            ),
          ),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: drawerAction(context).map((e) {
              return Column(
                children: [
                  Visibility(
                    visible: e['headLine'] ?? false,
                    child: const Divider(),
                  ),
                  ListTile(
                    onTap: e['action'],
                    style: ListTileStyle.drawer,
                    title: Text(
                      e['label'],
                    ),
                    leading: e['prefixIcon'],
                    trailing: e['suffixIcon'],
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

}

