import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinhmdev/l10n/generate/app_localizations.dart';
import 'package:vinhmdev/src/core/xdata.dart';
import 'dev_api_call_cubit.dart';
import 'dev_api_call_state.dart';

class DevApiCallPage extends StatelessWidget {
  const DevApiCallPage({super.key});

  Future<bool> _backButton(BuildContext context) async {
    var isExit = await showDialog<bool>(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Confirm Exit'), // todo lang
        content: Text('You want Exit API Call ?'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('OK'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('Cancel'),
          ),
        ],
      );
    },);
    return isExit ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<DevApiCallCubit>(context);
    final lang = AppLocalizations.of(context);

    return WillPopScope(
      onWillPop: () async => await _backButton(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            lang.devApiCallPage,
          ),
          leading: BackButton(
            onPressed: () async {
              if (await _backButton(context)) {
                Navigator.of(context).pop();
              }
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(RouterName.devApiCallSetting);
              },
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        body: BlocBuilder<DevApiCallCubit, DevApiCallState>(
          buildWhen: (previous, current) => previous.tabIndex != current.tabIndex,
          builder: (context, state) {
            return state.tabView;
          },
        ),
        bottomNavigationBar: BlocBuilder<DevApiCallCubit, DevApiCallState>(
          builder: (context, state) {
            return BottomNavigationBar(
              onTap: (int? tabSeleted) {
                cubit.changeTab(tabSeleted);
              },
              currentIndex: state.tabIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.compare_arrows),
                  label: 'sendTab#1', // todo lang
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: 'historyTab#2', // todo lang
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
