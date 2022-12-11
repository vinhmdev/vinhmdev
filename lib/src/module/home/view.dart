import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinhmdev/l10n/generate/app_localizations.dart';

import 'cubit.dart';
import 'state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeCubit(),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    var lang = AppLocalizations.of(context);

    return Scaffold(
      body: ListView(
        children: [
          Text(
            lang.homePage,
          )
        ],
      ),
    );
  }
}


