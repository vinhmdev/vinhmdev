import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinhmdev/l10n/generate/app_localizations.dart';

import 'cubit.dart';
import 'state.dart';

class TaskManagerPage extends StatelessWidget {
  const TaskManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TaskManagerCubit(),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final cubit = BlocProvider.of<TaskManagerCubit>(context);
    final lang = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          lang.taskManagerPage,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {

        },
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) => Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc eget consequat velit. Duis aliquam volutpat metus sed viverra. Donec hendrerit libero eget sagittis aliquet. Vivamus ac bibendum purus, id hendrerit orci. Pellentesque at nisi libero. Aliquam elementum arcu consectetur metus tempor feugiat. Proin molestie enim eu porttitor mollis. Duis id sapien in quam congue tristique eget quis mauris. Integer feugiat in lacus vitae consectetur. Nulla vehicula dapibus enim, eget auctor ipsum ornare in. Nulla faucibus orci non lacus feugiat rhoncus. Nunc congue sit amet quam eu pharetra. Vivamus gravida quam sem, non dapibus lorem venenatis eget. Fusce egestas quis dui quis mattis. Nulla eu dictum est.'),
        ),
      ),
    );
  }
}


