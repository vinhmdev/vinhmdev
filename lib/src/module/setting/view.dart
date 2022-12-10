import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinhmdev/src/module/global/cubit.dart';

import 'cubit.dart';
import 'state.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SettingCubit(),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final cubit = BlocProvider.of<SettingCubit>(context);
    final globalCubit = BlocProvider.of<GlobalCubit>(context);

    return ListView(
      children: [
        ElevatedButton(
          onPressed: () {
            globalCubit.setLocalization(Locale('en'));
          },
          child: Text('ok'),
        )
      ],
    );
  }
}


