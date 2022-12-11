import 'package:flutter_bloc/flutter_bloc.dart';

import 'state.dart';

class TaskManagerCubit extends Cubit<TaskManagerState> {
  TaskManagerCubit() : super(TaskManagerState().init());
}
