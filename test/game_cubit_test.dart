import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe_flutter_ui/game/cubit/game_cubit.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

void runTests() {
  group('GameCubit Tests', () {

    blocTest<GameCubit, GameState>(
      'Making multiple valid marks emits multiple GameInProgress states',
      build: () => GameCubit(),
      act: (cubit) {
        cubit.makeMark(Position(0, 0));
        cubit.makeMark(Position(1, 1));
        cubit.makeMark(Position(2, 2));
      },
      expect: () => [
        isA<GameInProgress>(),
        isA<GameInProgress>(),
        isA<GameInProgress>(),
      ],
    );

    blocTest<GameCubit, GameState>(
      'Make valid mark emits GameInProgress',
      build: () => GameCubit(),
      act: (cubit) => cubit.makeMark(Position(0, 0)),
      expect: () => [isA<GameInProgress>()],
    );


    blocTest<GameCubit, GameState>(
      'Make invalid mark emits GameError and then GameInitial',
      build: () => GameCubit(),
      act: (cubit) => cubit.makeMark(Position(-1, 3)), // An invalid position
      expect: () => [isA<GameError>()],
    );

    blocTest<GameCubit, GameState>(
      'Reset game emits GameInitial',
      build: () => GameCubit(),
      act: (cubit) => cubit.reset(),
      expect: () => [isA<GameInitial>()],
    );

    blocTest<GameCubit, GameState>(
      'Start and stop timer emits GameInProgress',
      build: () => GameCubit(),
      act: (cubit) async {
        cubit.startTimer();
        await Future.delayed(const Duration(milliseconds: 25));
        cubit.stopTimer();
      },
      expect: () => [isA<GameInProgress>()],
    );
  });
}
