import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinhmdev/src/core/app_utils.dart';
import 'package:vinhmdev/src/module/dev/dev_api_call/dev_api_call_cubit.dart';
import 'package:vinhmdev/src/module/dev/dev_api_call/dev_api_call_state.dart';
import 'package:vinhmdev/src/module/dev/dev_api_call/widget/dev_api_call_send_request_view.dart';

class DevApiCallSendResponsePage extends StatelessWidget {
  const DevApiCallSendResponsePage({super.key});

  String? getInfoRequest(BuildContext context, DevApiCallRequestState? state) {
    RequestOptions? requestInfo = state?.response?.requestOptions ?? state?.dioError?.requestOptions;
    if (requestInfo == null) {
      return null;
    }
    var configure = state!.configure;
    var result = '# >>> ${requestInfo.method  ?? '<Nothing>'}\n${requestInfo.uri ?? '<Nothing>'}\n\n'
        '# >>> Headers:\n${AppUtils.prettyJson(requestInfo.headers ?? '<Nothing>')}\n\n'
        '# >>> Body:\n${AppUtils.prettyJson(requestInfo.data ?? '<Nothing>')}'; // todo lang
    if (configure.isRqstShowCurlInfo) {
      result += '\n\n# >>> CURL:\n${AppUtils.getCurlReqeust(requestInfo)}';
    }
    return result;
  }

  String? getInfoResponse(BuildContext context, DevApiCallRequestState? state) {
    Response? response = state?.response;
    if (response == null) {
      return null;
    }
    return '# >>> Status:\n${response.statusCode  ?? '<Nothing>'} ${response.statusMessage ?? '<Nothing>'}\n\n'
        '# >>> Headers:\n${AppUtils.prettyJson(response.headers.map ?? '<Undefined>')}\n\n'
        '# >>> Body:\n${AppUtils.prettyJson(response.data ?? '<Undefined>')}';
  }

  String? getInfoError(BuildContext context, DevApiCallRequestState? state) {
    DioError? error = state?.dioError;
    if (error == null) {
      return null;
    }
    return '# >>> Message:\n${error.message ?? '<Nothing>'}\n\n'
        '# >>> Header:\n${AppUtils.prettyJson(error.response?.headers.map ?? '<Nothing>')}\n\n'
        '# >>> Status:\n${error.response?.statusCode  ?? '<Nothing>'} ${error.response?.statusMessage ?? '<Nothing>'}\n\n'
        '# >>> Body:\n${AppUtils.prettyJson(error.response?.statusMessage  ?? '<Nothing>')}';
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<DevApiCallCubit>(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        BlocSelector<DevApiCallCubit, DevApiCallState, DevApiCallRequestState?>(
          selector: (state) {
            if (state is DevApiCallRequestState) {
              return state;
            }
            return null;
          },
          builder: (context, state) {
            var infoRequest = getInfoRequest(context, state);
            if (infoRequest == null) {
              return const Center(
                child: Text('Request Not Found!'), // todo lang
              );
            }
            return Column(
              children: [
                InputJsonWidget(
                  textEditingController: TextEditingController(
                    text: infoRequest,
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
        BlocSelector<DevApiCallCubit, DevApiCallState, DevApiCallRequestState?>(
          selector: (state) {
            if (state is DevApiCallRequestState) {
              return state;
            }
            return null;
          },
          builder: (context, state) {
            String? infoResponse = getInfoResponse(context, state);
            if (infoResponse == null) {
              return const SizedBox.shrink();
            }
            return Column(
              children: [
                const SizedBox(height: 12,),
                InputJsonWidget(
                  textEditingController: TextEditingController(
                    text: infoResponse, // todo lang
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
        BlocSelector<DevApiCallCubit, DevApiCallState, DevApiCallRequestState?>(
          selector: (state) {
            if (state is DevApiCallRequestState) {
              return state;
            }
            return null;
          },
          builder: (context, state) {
            String? infoError = getInfoError(context, state);
            if (infoError == null) {
              return const SizedBox.shrink();
            }
            return Column(
              children: [
                const SizedBox(height: 12,),
                InputJsonWidget(
                  textEditingController: TextEditingController(
                    text: infoError, // todo lang
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
