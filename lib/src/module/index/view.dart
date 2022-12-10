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

  const IndexPage({super.key});

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
    final cubit = BlocProvider.of<IndexCubit>(context);

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
        drawer: const DrawerIndexPage(),
        body: BlocBuilder<IndexCubit, IndexState>(
          bloc: cubit,
          builder: (context, state) {
            switch (state.routerPage) {
              case RouterName.home:
                return const HomePage();
              case RouterName.setting:
                return SettingPage();
              default:
                return const SizedBox.shrink();
            }
          },
        )
    );
  }
}

class DrawerIndexPage extends StatelessWidget {
  const DrawerIndexPage({super.key});

  void gotoPage(BuildContext context, String routerName) {
    final cubit = BlocProvider.of<IndexCubit>(context);
    cubit.setRouter(routerName);

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
            child: const Text('Trang chủ'),
          ),
          TextButton(
            onPressed: () => gotoPage(context, RouterName.setting),
            child: const Text('Cài đặt'),
          ),
        ],
      ),
    );
  }

}

