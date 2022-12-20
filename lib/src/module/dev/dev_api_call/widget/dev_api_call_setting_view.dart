import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinhmdev/src/datasource/repositories/dev_api_call_configure.dart';
import 'package:vinhmdev/src/datasource/rest_datasource.dart';
import 'package:vinhmdev/src/module/dev/dev_api_call/dev_api_call_cubit.dart';

class DevApiCallSettingPage extends StatelessWidget {
  const DevApiCallSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<DevApiCallCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Api Call Config'), // todo lang
      ),
      body: ElevatedButton(
        onPressed: () async {
          cubit.updateConfigure(DevApiCallConfigure());
        },
        child: Text('Update Configure'),
      ),
    );
  }

}