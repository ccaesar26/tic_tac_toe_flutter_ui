import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe_flutter_ui/home/cubit/home_cubit.dart';

void runTests() {
  group('HomeCubit', () {
    blocTest<HomeCubit, HomeState>(
      'emits HomeState with selected mode',
      build: () => HomeCubit(),
      act: (cubit) {
        cubit.setMode(ModeType.easy); // Change the mode to the desired one
      },
      expect: () => const <HomeState>[
        HomeState(mode: ModeType.easy), // Ensure that the expected state is emitted
      ],
    );
  });
}
