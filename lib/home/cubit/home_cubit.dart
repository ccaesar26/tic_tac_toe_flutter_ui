import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void setMode(ModeType mode) => emit(HomeState(mode: mode));
}
