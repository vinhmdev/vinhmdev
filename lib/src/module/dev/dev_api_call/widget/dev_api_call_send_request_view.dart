import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinhmdev/src/core/app_utils.dart';
import 'package:vinhmdev/src/core/xdata.dart';
import 'package:vinhmdev/src/module/dev/dev_api_call/dev_api_call_cubit.dart';
import 'package:vinhmdev/src/module/dev/dev_api_call/dev_api_call_state.dart';

enum JsonType {
  auto, string, number, json, nullable;

  String get langName {
    return name.toUpperCase();
  }
}

class DevApiCallSendRequestPage extends StatelessWidget {

  final TabController tabController;
  final TextEditingController _inputMethod = TextEditingController();
  final TextEditingController _inputBaseApi = TextEditingController(text: 'https://');
  final TextEditingController _inputPath = TextEditingController();
  final TextEditingController _inputHeaderJson = TextEditingController();
  final TextEditingController _inputQueriesJson = TextEditingController();
  final TextEditingController _inputBodyJson = TextEditingController();
  // final TextEditingController _inputCurlRequest = TextEditingController();

  DevApiCallSendRequestPage({super.key, required this.tabController});

  String get urlRequest {
    var url = '${_inputBaseApi.text}${_inputPath.text}';
    return url;
  }

  Map<String, dynamic>? get headerRequest {
    try {
      return jsonDecode(_inputHeaderJson.text);
    }
    catch (error) {
      log('>>> $error', error: error);
      return null;
    }
  }

  Map<String, dynamic> get queriesRequest {
    try {
      return jsonDecode(_inputQueriesJson.text);
    }
    catch (error) {
      log('>>> $error', error: error);
      return {};
    }
  }

  dynamic get bodyRequest {
    try {
      return jsonDecode(_inputBodyJson.text);
    }
    catch (_) {
      if (_inputBodyJson.text.isNotEmpty) {
        return _inputBodyJson.text;
      }
      return null;
    }
  }

  Future<void> sendRequest(BuildContext context) async {
    AppUtils.unfocusKeyboard();
    try {
      final cubit = BlocProvider.of<DevApiCallCubit>(context);
      var path = urlRequest;
      var query = '';
      if (urlRequest.contains('?')){
        path = urlRequest.substring(0, urlRequest.lastIndexOf('?'));
        query = urlRequest.substring(urlRequest.lastIndexOf('?') + 1);
      }
      queriesRequest.forEach((key, value) {
        if (query.isNotEmpty) {
          query += '&';
        }
        query += '$key=${value ?? ''}';
      });

      if (query.isNotEmpty && !query.startsWith('?')){
        query = '?$query';
      }

      var uri = Uri.parse('$path$query');
      await cubit.sendRequest(
        uri: uri,
        headers: headerRequest,
        body: bodyRequest,
        method: _inputMethod.text,
      );
    }
    catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$_')));
    }
    tabController.animateTo(1);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on),
                    const SizedBox(width: 8,),
                    Text(
                      'Request', // todo lang
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    SizedBox(
                      width: 160,
                      child: Autocomplete(
                        initialValue: _inputMethod.value,
                        fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                          return TextFormField(
                            controller: textEditingController,
                            decoration: const InputDecoration(
                              labelText: 'Method (GET)', // todo lang
                              suffixIcon: Icon(Icons.add_comment),
                            ),
                            focusNode: focusNode,
                            onFieldSubmitted: (_) => onFieldSubmitted(),
                          );
                        },
                        optionsBuilder: (textEditingValue) {
                          var text = textEditingValue.text.trim().toUpperCase();
                          if (text.isEmpty) {
                            return XData.devApiCallMethodRequest;
                          }
                          var result = [
                            text.toUpperCase(),
                            ...XData.devApiCallMethodRequest.where((element) => element.contains(text))
                          ];
                          _inputMethod.text = textEditingValue.text;
                          return result;
                        },
                        onSelected: (val) {
                          _inputMethod.text = val;
                        },
                      ),
                    ),
                    const SizedBox(width: 12,),
                    Expanded(
                      child: TextFormField(
                        controller: _inputBaseApi,
                        decoration: const InputDecoration(
                          labelText: 'Base api', // todo lang
                          suffixIcon: Icon(Icons.home),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12,),
                TextFormField(
                  controller: _inputPath,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.link),
                    labelText: 'Input url request', // todo lang
                  ),
                ),
                const SizedBox(height: 24,),
                InputJsonWidget(
                  textEditingController: _inputQueriesJson,
                  iconTitle: const Icon(Icons.add_box),
                  title: 'Queries', // todo lang
                  label: 'Queries json', // todo lang
                  padding: EdgeInsets.zero,
                  elevation: 0,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12,),
        InputJsonWidget(
          textEditingController: _inputHeaderJson,
          iconTitle: const Icon(Icons.add_box),
          title: 'Header', // todo lang
          label: 'Header json', // todo lang
        ),
        const SizedBox(height: 12,),
        InputJsonWidget(
          textEditingController: _inputBodyJson,
          iconTitle: const Icon(Icons.add_box),
          title: 'Body', // todo lang
          label: 'Body json', // todo lang
        ),
        const SizedBox(height: 12,),
        ElevatedButton.icon(
          onPressed: () async {
            await sendRequest(context);
          },
          icon: const Icon(Icons.send),
          label: const Text('Request'), // todo lang
        ),
        BlocSelector<DevApiCallCubit, DevApiCallState, RequestOptions?>(
          selector: (state) {
            if (state is DevApiCallRequestState) {
              return state.response?.requestOptions ?? state.dioError?.requestOptions;
            }
            return null;
          },
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(height: 12,),
                InputJsonWidget(
                  iconTitle: const Icon(Icons.add_box),
                  textEditingController: TextEditingController(text: AppUtils.getCurlReqeust(state)),
                  title: 'CURL request', // todo lang
                  label: 'CURL request content', // todo lang
                  isShowAddJson: false,
                  isShowPretty: false,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class InputJsonWidget extends StatelessWidget {

  final TextEditingController? textEditingController;
  final Widget? iconTitle;
  final List<Widget>? bottom;
  final String title;
  final String label;
  final bool isShowPretty;
  final bool isShowAddJson;
  final bool isShowCopy;
  final bool isReadOnly;
  final bool isMonospacedFont;
  final EdgeInsets? padding;
  final double? elevation;

  const InputJsonWidget({
    super.key,
    this.textEditingController,
    this.iconTitle,
    this.bottom,
    this.title = '',
    this.label = '',
    this.isShowPretty = true,
    this.isShowAddJson = true,
    this.isShowCopy = true,
    this.isMonospacedFont = true,
    this.isReadOnly = true,
    this.padding,
    this.elevation,
  });

  void prettyJson() {
    try {
      var jsonString = textEditingController?.text ?? '';
      var json = jsonDecode(jsonString);
      var result = AppUtils.prettyJson(json);
      textEditingController?.text = result;
    }
    catch (error) {
      log('>>> $error', error: error);
    }
  }

  Future<void> copy([BuildContext? context]) async {
    await AppUtils.copyToClipboard(textEditingController?.text, context: context);
  }

  void add(
      String key,
      String value,
      {
        JsonType? jsonType = JsonType.auto,
        bool isThrowException = false,
      }) {
    try {
      var jsonString = textEditingController?.text ?? '';
      Map<String, dynamic> json;
      try {
        json = jsonDecode(jsonString);
      } catch (_) {
        if ((textEditingController?.text ?? '').isNotEmpty) {
          json = {
            '_body': textEditingController?.text,
          };
        }
        else {
          json = {};
        }
      }
      switch (jsonType ?? JsonType.auto) {
        case JsonType.nullable:
          json[key] = null;
          break;
        case JsonType.string:
          json[key] = value.toString();
          break;
        case JsonType.number:
          json[key] = num.parse(value);
          break;
        case JsonType.json:
          json[key] = jsonDecode(value);
          break;
        case JsonType.auto:
        default:
          try {
            json[key] = jsonDecode(value);
          }
          catch (_) {
            try {
              json[key] = num.parse(value);
            } catch (_) {
              json[key] = value;
            }
          }
          break;
      }
      var result = AppUtils.prettyJson(json);
      textEditingController?.text = result;
    }
    catch (error) {
      if (isThrowException) {
        rethrow;
      }
      log('>>> $error', error: error);
    }
  }


  Future<void> showAddDialog(BuildContext context) async {
    var inputKey = TextEditingController();
    var inputValue = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add value'), // todo lang
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: inputKey,
                decoration: const InputDecoration(
                  labelText: 'Key', // todo lang
                ),
              ),
              TextField(
                controller: inputValue,
                decoration: const InputDecoration(
                  labelText: 'Value', // todo lang
                ),
                minLines: 1,
                maxLines: 8,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.tertiary,
              ),
              onPressed: () => Navigator.of(context).maybePop(),
              child: const Text('Cancel'), // todo lang
            ),
            ElevatedButton(
              onPressed: () async {
                JsonType? type = await showDialog<JsonType>(context: context, builder: (context) {
                  return AlertDialog(
                    title: const Text('Seletect a type'), // todo lang
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: JsonType.values.map((e) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              AppUtils.unfocusKeyboard();
                              Navigator.of(context).pop(e);
                            },
                            child: Text(e.langName), // todo lang
                          ),
                        );
                      }).toList(),
                    ),
                  );
                });
                try {
                  add(inputKey.text, inputValue.text, jsonType: type, isThrowException: true);
                  Navigator.of(context).pop();
                }
                catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$e',),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              child: const Text('Type'), // todo lang
            ),
            ElevatedButton(
              onPressed: () {
                add(inputKey.text, inputValue.text);
                Navigator.of(context).maybePop();
              },
              child: const Text('OK'), // todo lang
            ),
          ],
        );
      },);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      child: Padding(
        padding: padding ?? const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                iconTitle ?? const SizedBox.shrink(),
                const SizedBox(width: 8,),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const Divider(),
            TextFormField(
              controller: textEditingController,
              readOnly: !isReadOnly,
              decoration: InputDecoration(
                labelText: label,
              ),
              style: TextStyle(
                fontFamily: isMonospacedFont ? 'CascadiaMonoPL' : null,
              ),
              minLines: 1,
              maxLines: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ...?bottom,
                const Expanded(child: SizedBox.shrink()),
                Visibility(
                  visible: isShowAddJson,
                  child: ElevatedButton(
                    onPressed: () async {
                      await showAddDialog(context);
                    },
                    child: const Text('Add'), // todo lang
                  ),
                ),
                const SizedBox(width: 8,),
                Visibility(
                  visible: isShowAddJson,
                  child: ElevatedButton(
                    onPressed: prettyJson,
                    child: const Text('Pretty'), // todo lang
                  ),
                ),
                const SizedBox(width: 8,),
                Visibility(
                  visible: isShowCopy,
                  child: ElevatedButton(
                    onPressed: () => copy(context),
                    child: const Text('Copy'), // todo lang
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}