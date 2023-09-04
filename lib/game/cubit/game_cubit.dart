import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe_flutter_ui/home/home.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  final _game = Game();

  GameCubit()
      : super(GameInitial()) {
    _game.onMarkCallback = Callback.withCallback(() {
      emit(GameInProgress(
        board: _game.board,
        currentPlayer: _game.currentPlayer,
      ));
    });
    _game.onGameOverCallback = Callback.withCallback((GameResult result) {
      switch (result) {
        case GameResult.xWon:
          emit(GameWon(Mark.X));
          break;
        case GameResult.oWon:
          emit(GameWon(Mark.O));
          break;
        case GameResult.draw:
          emit(GameDraw());
          break;
      }
    });
    _game.onTurnSwitchCallback = Callback.withCallback(() {
      emit(GameInProgress(
        board: _game.board,
        currentPlayer: _game.currentPlayer,
      ));
    });
    //_game.logPath = 'game_cubit.log';
  }

  void makeMark(Position position) {
    if (_game.isNotGameOver) {
      try {
        _game.makeMark(position);
      } on InvalidPositionException {
        emit(GameError("Invalid position. Please choose another position.", _game.board, _game.currentPlayer));
      } on InvalidMarkingException {
        emit(GameError("Position already marked. Choose an empty position.", _game.board, _game.currentPlayer));
      }
    }
  }

  void reset() {
    _game.reset();
    if(!isClosed){
      emit(GameInitial());
    }
  }

  set strategy(ModeType mode) => _game.strategy = mode.strategy;
}
