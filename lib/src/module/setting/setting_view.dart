import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinhmdev/l10n/generate/app_localizations.dart';
import 'package:vinhmdev/src/module/global/global_cubit.dart';

import 'setting_cubit.dart';
import 'setting_state.dart';

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
    String? defaultLocalization = globalCubit.state.locale?.languageCode;
    if (defaultLocalization?.isEmpty ?? false) {
      defaultLocalization = null;
    }

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.design_services),
                      const SizedBox(width: 8,),
                      Text(
                        lang.settingDesign,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 12,),
                  Text(
                    lang.settingLanguage,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  BlocBuilder<SettingCubit, SettingState>(
                    bloc: cubit,
                    buildWhen: (pre, cur) {
                      return pre.localeSubmit != cur.localeSubmit;
                    },
                    builder: (context, state) {
                      return DropdownButton<String>(
                        value: state.localeSubmit?.languageCode ?? defaultLocalization,
                        isExpanded: true,
                        hint: Text(lang.settingLanguageHint),
                        items: [
                          DropdownMenuItem<String>(
                            value: 'vi',
                            child: Text(lang.settingLanguageVi),
                          ),
                          DropdownMenuItem<String>(
                            value: 'en',
                            child: Text(lang.settingLanguageEn),
                          ),
                        ],
                        onChanged: (String? localeName) {
                          if (localeName?.isNotEmpty ?? false) {
                            cubit.localeSelected(Locale(localeName!));
                          }
                          else {
                            cubit.localeSelected(null);
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 14,),
                  Text(
                    lang.settingTheme,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  BlocBuilder<SettingCubit, SettingState>(
                    bloc: cubit,
                    buildWhen: (pre, cur) {
                      return pre.themeMode != cur.themeMode;
                    },
                    builder: (context, state) {
                      return DropdownButton<ThemeMode>(
                        value: state.themeMode ?? globalCubit.state.themeMode,
                        isExpanded: true,
                        hint: Text(lang.settingThemeHint),
                        items: [
                          DropdownMenuItem<ThemeMode>(
                            value: ThemeMode.system,
                            child: Text(lang.settingThemeSystem),
                          ),
                          DropdownMenuItem<ThemeMode>(
                            value: ThemeMode.light,
                            child: Text(lang.settingThemeLight),
                          ),
                          DropdownMenuItem<ThemeMode>(
                            value: ThemeMode.dark,
                            child: Text(lang.settingThemeDark),
                          ),
                        ],
                        onChanged: (ThemeMode? themeMode) {
                          cubit.themeSelected(themeMode ?? globalCubit.state.themeMode);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12,),
          ElevatedButton(
            onPressed: () async {
              globalCubit.setConfig(
                locale: cubit.state.localeSubmit,
                themeMode: cubit.state.themeMode,
              );
            },
            child: Text(lang.settingSettingSave),
          ),
          const SizedBox(height: 16,),
        ],
      ),
    );
  }

}
