import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe_flutter_ui/home/home.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  final Game _game;

  var x = 0;

  GameCubit([Game? game])
      : _game = game ?? Game(),
        super(GameInitial()) {
    _game.onMarkCallback = Callback.withCallback(() {
      emit(GameInProgress(
        board: _game.board,
        currentPlayer: _game.currentPlayer,
        remaining: _game.timerRemaining,
      ));
    });
    _game.onGameOverCallback = Callback.withCallback((GameResult result) {
      switch (result) {
        case GameResult.xWon:
          emit(GameWon(
            winner: Mark.X,
            board: _game.board,
            currentPlayer: _game.currentPlayer,
            remaining: _game.timerRemaining,
          ));
          break;
        case GameResult.oWon:
          emit(GameWon(
            winner: Mark.O,
            board: _game.board,
            currentPlayer: _game.currentPlayer,
            remaining: _game.timerRemaining,
          ));
          break;
        case GameResult.draw:
          emit(GameDraw(
            board: _game.board,
            currentPlayer: _game.currentPlayer,
            remaining: _game.timerRemaining,
          ));
          break;
      }
    });
    //_game.logPath = 'game_cubit.log';
    _game.timerSeconds = 10;
    _game.onTimerTickFunction = (Duration remaining) {
      emit(GameInProgress(
        board: _game.board,
        currentPlayer: _game.currentPlayer,
        remaining: remaining,
      ));
    };
    _game.onTimerEndFunction = () {
      switch (_game.currentPlayer) {
        case Mark.X:
          emit(GameWon(
            winner: Mark.O,
            board: _game.board,
            currentPlayer: _game.currentPlayer,
            remaining: _game.timerRemaining,
          ));
          break;
        case Mark.O:
          emit(GameWon(
            winner: Mark.X,
            board: _game.board,
            currentPlayer: _game.currentPlayer,
            remaining: _game.timerRemaining,
          ));
          break;
        default:
          break;
      }
    };
  }

  void makeMark(Position position) {
    if (_game.isNotGameOver) {
      try {
        _game.makeMark(position);
      } on InvalidPositionException {
        emit(GameError("Invalid position. Please choose another position.",
            _game.board, _game.currentPlayer));
      } on InvalidMarkingException {
        emit(GameError("Position already marked. Choose an empty position.",
            _game.board, _game.currentPlayer));
      }
    }
  }

  void reset() {
    _game.reset();
    if (!isClosed) {
      emit(GameInitial());
    }
  }

  set strategy(ModeType mode) => _game.strategy = mode.strategy;

  void startTimer() => _game.startTimer();

  void stopTimer() => _game.stopTimer();

  void switchTimer() {
    if (_game.isTimerRunning) {
      _game.pauseTimer();
    } else {
      _game.resumeTimer();
    }
  }

  void resumeTimer() {
    _game.startTimer();
  }

  final _resumeSignal = Completer<void>();

  void pauseTimer() => _game.pauseTimer();

  void resumeGame() => _resumeSignal.complete();

  bool get isTimerRunning => _game.isTimerRunning;
}
