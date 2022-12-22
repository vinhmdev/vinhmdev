import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinhmdev/src/datasource/repositories/dev_api_call_configure.dart';
import 'package:vinhmdev/src/datasource/rest_datasource.dart';
import 'package:vinhmdev/src/module/dev/dev_api_call/dev_api_call_cubit.dart';
import 'package:vinhmdev/src/module/dev/dev_api_call/dev_api_call_state.dart';

class DevApiCallSettingPage extends StatelessWidget {
  const DevApiCallSettingPage({super.key});

  Future<void> _backButton(BuildContext context) async {
    final cubit = BlocProvider.of<DevApiCallCubit>(context);
    await cubit.clearCacheConfigure();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<DevApiCallCubit>(context);
    final configure = cubit.getConfigure();
    cubit.clearCacheConfigure();

    var checkboxList = [
      [
        {
          "header": "Request",
          "headerIcon": const Icon(Icons.upload),
          "label": "Show CURL", // todo lang
          "selector": (DevApiCallState state) {
            if (state is DevApiCallRequestState) {
              return state.configure.isRqstShowCurlInfo;
            }
            return null;
          },
          "onChange": (DevApiCallCubit cubit, bool? newValue) async
          => cubit.updateConfigure((await cubit.getConfigure()).copyWith(
            isRqstShowCurlInfo: newValue ?? false,
          ), false),
        },
      ],
      [
        {
          "header": "Response",
          "headerIcon": const Icon(Icons.download),
          "label": "Show request info", // todo lang
          "selector": (DevApiCallState state) {
            if (state is DevApiCallRequestState) {
              return state.configure.isRspShowRequestInfo;
            }
            return null;
          },
          "onChange": (DevApiCallCubit cubit, bool? newValue) async
          => cubit.updateConfigure((await cubit.getConfigure()).copyWith(
            isRspShowRequestInfo: newValue ?? false,
          ), false),
        },
        // {
        //   "label": "Show message info", // todo lang
        //   "selector": (DevApiCallState state) {
        //     if (state is DevApiCallRequestState) {
        //       return state.configure.isRspShowMessageInfo;
        //     }
        //     return null;
        //   },
        //   "onChange": (DevApiCallCubit cubit, bool? newValue) async
        //   => cubit.updateConfigure((await cubit.getConfigure()).copyWith(
        //     isRspShowMessageInfo: newValue ?? false,
        //   ), false,),
        // },
        {
          "label": "Show status info", // todo lang
          "selector": (DevApiCallState state) {
            if (state is DevApiCallRequestState) {
              return state.configure.isRspShowStatusInfo;
            }
            return null;
          },
          "onChange": (DevApiCallCubit cubit, bool? newValue) async
          => cubit.updateConfigure((await cubit.getConfigure()).copyWith(
            isRspShowStatusInfo: newValue ?? false,
          ), false,),
        },
        {
          "label": "Show header info", // todo lang
          "selector": (DevApiCallState state) {
            if (state is DevApiCallRequestState) {
              return state.configure.isRspShowHeadersInfo;
            }
            return null;
          },
          "onChange": (DevApiCallCubit cubit, bool? newValue) async
          => cubit.updateConfigure((await cubit.getConfigure()).copyWith(
            isRspShowHeadersInfo: newValue ?? false,
          ), false,),
        },
        {
          "label": "Show body info", // todo lang
          "selector": (DevApiCallState state) {
            if (state is DevApiCallRequestState) {
              return state.configure.isRspShowBodyInfo;
            }
            return null;
          },
          "onChange": (DevApiCallCubit cubit, bool? newValue) async
          => cubit.updateConfigure((await cubit.getConfigure()).copyWith(
            isRspShowBodyInfo: newValue ?? false,
          ), false,),
        },
      ],
      [
        {
          "header": "Error",
          "headerIcon": const Icon(Icons.error),
          "label": "Show request info", // todo lang
          "selector": (DevApiCallState state) {
            if (state is DevApiCallRequestState) {
              return state.configure.isErShowRequestInfo;
            }
            return null;
          },
          "onChange": (DevApiCallCubit cubit, bool? newValue) async
          => cubit.updateConfigure((await cubit.getConfigure()).copyWith(
            isErShowRequestInfo: newValue ?? false,
          ), false),
        },
        {
          "label": "Show message info", // todo lang
          "selector": (DevApiCallState state) {
            if (state is DevApiCallRequestState) {
              return state.configure.isErShowMessageInfo;
            }
            return null;
          },
          "onChange": (DevApiCallCubit cubit, bool? newValue) async
          => cubit.updateConfigure((await cubit.getConfigure()).copyWith(
            isErShowMessageInfo: newValue ?? false,
          ), false,),
        },
        {
          "label": "Show status info", // todo lang
          "selector": (DevApiCallState state) {
            if (state is DevApiCallRequestState) {
              return state.configure.isErShowStatusInfo;
            }
            return null;
          },
          "onChange": (DevApiCallCubit cubit, bool? newValue) async
          => cubit.updateConfigure((await cubit.getConfigure()).copyWith(
            isErShowStatusInfo: newValue ?? false,
          ), false,),
        },
        {
          "label": "Show header info", // todo lang
          "selector": (DevApiCallState state) {
            if (state is DevApiCallRequestState) {
              return state.configure.isErShowHeadersInfo;
            }
            return null;
          },
          "onChange": (DevApiCallCubit cubit, bool? newValue) async
          => cubit.updateConfigure((await cubit.getConfigure()).copyWith(
            isErShowHeadersInfo: newValue ?? false,
          ), false,),
        },
        {
          "label": "Show body info", // todo lang
          "selector": (DevApiCallState state) {
            if (state is DevApiCallRequestState) {
              return state.configure.isErShowBodyInfo;
            }
            return null;
          },
          "onChange": (DevApiCallCubit cubit, bool? newValue) async
          => cubit.updateConfigure((await cubit.getConfigure()).copyWith(
            isErShowBodyInfo: newValue ?? false,
          ), false,),
        },
      ],

    ];

    return WillPopScope(
      onWillPop: () async {
        await _backButton(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => _backButton(context),
          ),
          title: const Text('Api Call Config'), // todo lang
        ),
        body: FutureBuilder(
          future: configure,
          builder: (context, configure) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ...checkboxList.map((e) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Card(
                      child: Column(
                        children: e.map((e) {
                          return Column(
                            children: [
                              Visibility(
                                visible: e['header'] != null,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8).copyWith(bottom: 0),
                                      child: Row(
                                        children: [
                                          (e['headerIcon'] as Widget?) ?? const SizedBox.shrink(),
                                          const SizedBox(width: 8,),
                                          Text(
                                            '${e['header']}',
                                            style: Theme.of(context).textTheme.titleLarge,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(),
                                  ],
                                ),
                              ),
                              BlocSelector<DevApiCallCubit, DevApiCallState, bool?>(
                                selector: e['selector'] as bool? Function(DevApiCallState),
                                builder: (context, state) {
                                  return CheckboxListTile(
                                    value: state ?? false,
                                    onChanged: (newValue) {
                                      (e['onChange'] as Function(DevApiCallCubit, bool?))(cubit, newValue);
                                    },
                                    contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                                    controlAffinity: ListTileControlAffinity.leading,
                                    title: Text(e['label']?.toString() ?? '--'),
                                  );
                                },
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  );
                }).toList(),
                ElevatedButton(
                  onPressed: () async {
                    await cubit.updateConfigure(await cubit.getConfigure());
                    Navigator.of(context).pop();
                  },
                  child: const Text('Update Configure'), // todo lang
                ),
              ],
            );
          }
        ),
      ),
    );
  }

}