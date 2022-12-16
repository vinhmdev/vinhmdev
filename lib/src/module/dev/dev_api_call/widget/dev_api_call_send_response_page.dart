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
          buildWhen: (previous, current) {
            if (current is DevApiCallRequestState && previous is DevApiCallRequestState) {
              return true; // todo equatable it
            }
            return previous is! DevApiCallRequestState && current is DevApiCallRequestState;
          },
          builder: (context, _state) {
            DevApiCallRequestState? state;
            if (_state is DevApiCallRequestState) {
              state = _state;
            }
            return Column(
              children: [
                InputJsonWidget(
                  textEditingController: TextEditingController(
                    text: AppUtils.prettyJson(state?.response?.data ?? '<Undefined>'), // todo lang
                  ),
                  title: 'Response', // todo lang
                  isShowAddJson: false,
                  isShowPretty: false,
                  isReadOnly: false,
                ),
              ],
            );
          },
        ),
        const Divider(),
        Text('ok'),
      ],
    );
  }

}
