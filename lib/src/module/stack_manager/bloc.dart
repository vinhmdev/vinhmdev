import 'package:bloc/bloc.dart';

import 'event.dart';
import 'state.dart';

class StackManagerBloc extends Bloc<StackManagerEvent, StackManagerState> {
  StackManagerBloc() : super(StackManagerState().init()) {
    on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<StackManagerState> emit) async {
    emit(state.clone());
  }
}
