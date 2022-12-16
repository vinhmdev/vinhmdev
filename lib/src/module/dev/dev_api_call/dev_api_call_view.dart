import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinhmdev/l10n/generate/app_localizations.dart';
import 'package:vinhmdev/src/datasource/rest_datasource.dart';

import 'dev_api_call_cubit.dart';
import 'dev_api_call_state.dart';

class DevApiCallPage extends StatelessWidget {
  const DevApiCallPage({super.key});

  void addApi(DevApiCallCubit cubit) {

  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DevApiCallCubit(
        RepositoryProvider.of<RestDatasource>(context),
      ),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final cubit = BlocProvider.of<DevApiCallCubit>(context);
    final lang = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          lang.devApiCallPage,
        ),
      ),
      body: BlocBuilder<DevApiCallCubit, DevApiCallState>(
        buildWhen: (previous, current) => previous.tabIndex != current.tabIndex,
        builder: (context, state) {
          return state.tabView;
        },
      ),
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom.toInt() <= 0,
        child: FloatingActionButton(
          onPressed: () => addApi(cubit),
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
    );
  }
}


