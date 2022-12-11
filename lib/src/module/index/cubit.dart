import 'package:flutter_bloc/flutter_bloc.dart';

import 'state.dart';

class IndexCubit extends Cubit<IndexState> {
  IndexCubit() : super(IndexState().init());

  void setRouter(String home) {
    emit(IndexState(routerPage: home));
  }

}
