import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vinhmdev/src/core/app_utils.dart';
import 'package:vinhmdev/src/core/xdata.dart';

class DevApiCallSendPage extends StatefulWidget{
  const DevApiCallSendPage({super.key});

  @override
  State<DevApiCallSendPage> createState() => _DevApiCallSendPageState();
}

class _DevApiCallSendPageState extends State<DevApiCallSendPage> with TickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: Icon(Icons.upload),
            ),
            Tab(
              icon: Icon(Icons.download),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _DevApiCallSendRequestPage(),
          _DevApiCallSendResponsePage(),
        ],
      ),
    );
  }
}

class _DevApiCallSendRequestPage extends StatelessWidget {
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
                          return result;
                        },
                        onSelected: (val) {
                          debugPrint('>>>>>>>> $val'); // todo selected this
                        },
                      ),
                    ),
                    const SizedBox(width: 12,),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Base API', // todo lang
                          suffixIcon: Icon(Icons.home),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12,),
                TextFormField(
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.link),
                    labelText: 'Input URL Request', // todo lang
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12,),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.add_comment),
                    const SizedBox(width: 8,),
                    Text(
                      'Header', // todo lang
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const Divider(),
                TextFormField(
                  initialValue: AppUtils.prettyJson(XData.devApiCallHeaderRequest),
                  decoration: InputDecoration(
                    labelText: 'Header Json',
                  ),
                  style: TextStyle(
                    fontFamily: 'CascadiaMonoPL',
                  ),
                  minLines: 1,
                  maxLines: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('add'),
                    ),
                    SizedBox(width: 8,),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('pretty'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12,),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.add_circle),
                    const SizedBox(width: 8,),
                    Text(
                      'Queries', // todo lang
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const Divider(),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Queries Json',
                  ),
                  minLines: 1,
                  maxLines: 25,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12,),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.add_box),
                    const SizedBox(width: 8,),
                    Text(
                      'Body', // todo lang
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const Divider(),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Body Json',
                  ),
                  minLines: 1,
                  maxLines: 25,
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 12,),
        ElevatedButton.icon(
          onPressed: () {

          },
          icon: const Icon(Icons.send),
          label: const Text('Request'), // todo lang
        ),
        const SizedBox(height: 12,),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.history_edu),
                    const SizedBox(width: 8,),
                    Text(
                      'Request CURL', // todo lang
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const Divider(),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Body Json',
                  ),
                  minLines: 1,
                  maxLines: 25,
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 24,),
      ],
    );
  }
}

class _DevApiCallSendResponsePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text('ok'),
      ],
    );
  }

}
