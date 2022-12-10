import 'package:bloc/bloc.dart';

import 'state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingState().init());
}
