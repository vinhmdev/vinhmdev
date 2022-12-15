import 'package:flutter_bloc/flutter_bloc.dart';

import 'global_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState().init());
}
