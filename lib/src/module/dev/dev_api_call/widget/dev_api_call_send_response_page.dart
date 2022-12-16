import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinhmdev/src/core/app_utils.dart';
import 'package:vinhmdev/src/module/dev/dev_api_call/dev_api_call_cubit.dart';
import 'package:vinhmdev/src/module/dev/dev_api_call/dev_api_call_state.dart';
import 'package:vinhmdev/src/module/dev/dev_api_call/widget/dev_api_call_send_request_page.dart';

class DevApiCallSendResponsePage extends StatelessWidget {
  const DevApiCallSendResponsePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<DevApiCallCubit>(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        BlocBuilder<DevApiCallCubit, DevApiCallState>(
          builder: (context, st) {
            DevApiCallRequestState? state;
            if (st is DevApiCallRequestState) {
              state = st;
            }
            var requestInfo = state?.response?.requestOptions ?? state?.dioError?.requestOptions;
            if (requestInfo == null) {
              return const Center(
                child: Text('Nothing!'), // todo lang
              );
            }

            return Column(
              children: [
                InputJsonWidget(
                  textEditingController: TextEditingController(
                    text: '# >>> ${requestInfo.method  ?? '<Nothing>'}\n${requestInfo.path ?? '<Nothing>'}\n\n'
                        '# >>> Headers:\n${AppUtils.prettyJson(requestInfo.headers ?? '<Nothing>')}\n\n'
                        '# >>> Body:\n${AppUtils.prettyJson(requestInfo.data ?? '<Nothing>')}', // todo lang
                  ),
                  title: 'Request status', // todo lang
                  label: 'Request info',
                  isShowAddJson: false,
                  isShowPretty: false,
                  isReadOnly: false,
                ),
              ],
            );
          },
        ),
        BlocBuilder<DevApiCallCubit, DevApiCallState>(
          buildWhen: (previous, current) {
            if (current is DevApiCallRequestState && previous is DevApiCallRequestState) {
              return previous.response != current.response; // todo equatable it
            }
            return current is DevApiCallRequestState && previous is! DevApiCallRequestState;
          },
          builder: (context, st) {
            DevApiCallRequestState? state;
            if (st is DevApiCallRequestState) {
              state = st;
            }
            if (state?.response == null) {
              return const SizedBox.shrink();
            }
            return Column(
              children: [
                const SizedBox(height: 12,),
                InputJsonWidget(
                  textEditingController: TextEditingController(
                    text: '# >>> ${state?.response?.requestOptions.method  ?? '<Nothing>'}\n${state?.response?.requestOptions.uri ?? '<Nothing>'}\n\n'
                        '# >>> Status:\n${state?.response?.statusCode  ?? '<Nothing>'}\n${state?.response?.statusMessage ?? '<Nothing>'}\n\n'
                        '# >>> Body:\n${AppUtils.prettyJson(state?.response?.data ?? '<Undefined>')}', // todo lang
                  ),
                  title: 'Response status', // todo lang
                  label: 'Response info',
                  isShowAddJson: false,
                  isShowPretty: false,
                  isReadOnly: false,
                ),
              ],
            );
          },
        ),
        BlocBuilder<DevApiCallCubit, DevApiCallState>(
          buildWhen: (previous, current) {
            if (current is DevApiCallRequestState && previous is DevApiCallRequestState) {
              return previous.dioError != current.dioError; // todo equatable it
            }
            return current is DevApiCallRequestState && previous is! DevApiCallRequestState;
          },
          builder: (context, st) {
            DevApiCallRequestState? state;
            if (st is DevApiCallRequestState) {
              state = st;
            }
            if (state?.dioError == null) {
              return const SizedBox.shrink();
            }
            return Column(
              children: [
                const SizedBox(height: 12,),
                InputJsonWidget(
                  textEditingController: TextEditingController(
                    text: '# >>> Message:\n${state?.dioError?.message ?? '<Nothing>'}\n\n'
                        '# >>> Status:\n${state?.dioError?.response?.statusCode  ?? '<Nothing>'} | ${state?.dioError?.response?.statusMessage ?? '<Nothing>'}\n\n'
                        '# >>> Body:\n${AppUtils.prettyJson(state?.dioError?.response?.statusMessage  ?? '<Nothing>')}', // todo lang
                  ),
                  title: 'Error status', // todo lang
                  label: 'Error info',
                  isShowAddJson: false,
                  isShowPretty: false,
                  isReadOnly: false,
                ),
              ],
            );
          },
        ),
      ],
    );
  }

}
