import 'package:flutter_bloc/flutter_bloc.dart';

import 'task_manager_state.dart';

class TaskManagerCubit extends Cubit<TaskManagerState> {
  TaskManagerCubit() : super(TaskManagerState().init());
}
