import 'package:flutter_bloc/flutter_bloc.dart';

import 'state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState().init());
}
