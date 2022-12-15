import 'package:vinhmdev/src/core/xdata.dart';

class IndexState {
  IndexState init() {
    return IndexState();
  }

  IndexState({
    this.routerPage = RouterName.home,
  });

  String routerPage;
}
