import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinhmdev/src/module/dev/dev_api_call/dev_api_call_cubit.dart';

class DevApiCallHistoryPage extends StatelessWidget {
  const DevApiCallHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<DevApiCallCubit>(context);


    return Scaffold(
      appBar: AppBar(
        title: Text('history'),
      ),
      body: Text('ok'),
    );
  }

}