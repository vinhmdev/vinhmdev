import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinhmdev/l10n/generate/app_localizations.dart';
import 'package:vinhmdev/src/module/global/cubit.dart';

import 'cubit.dart';
import 'state.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

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
    final lang = AppLocalizations.of(context);
    String defaultLocalization = globalCubit.state.locale?.languageCode ?? '';

    return ListView(
      children: [
        DropdownButton<String>(
          value: defaultLocalization,
          items: [
            DropdownMenuItem<String>(
              value: '',
              child: Text('Tự động'),
            ),
            DropdownMenuItem<String>(
              value: 'vi',
              child: Text('Tiếng Việt'),
            ),
            DropdownMenuItem<String>(
              value: 'en',
              child: Text('English'),
            ),
          ],
          onChanged: (String? localeName) {
            if (localeName?.isNotEmpty ?? false) {

              // globalCubit.setLocalization(Locale(localeName!));
            }
            else {
              globalCubit.setLocalization(null);
            }
          },
        ),
      ],
    );
  }
}


