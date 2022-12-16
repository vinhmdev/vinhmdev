import 'package:flutter/material.dart';
import 'package:vinhmdev/src/module/dev/dev_api_call/widget/dev_api_call_send_request_page.dart';

import 'dev_api_call_send_response_page.dart';

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
          DevApiCallSendRequestPage(),
          DevApiCallSendResponsePage(),
        ],
      ),
    );
  }
}
