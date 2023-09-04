part of 'game_cubit.dart';

abstract class GameState extends Equatable {
  const GameState(this.board, this.currentPlayer);

  final Board board;
  final Mark currentPlayer;

  @override
  List<Object> get props => [board, currentPlayer];
}

class GameInitial extends GameState {
  GameInitial() : super(Board(3), Mark.X);
}

class GameInProgress extends GameState {

  const GameInProgress({
    required Board board,
    required Mark currentPlayer,
  }) : super(board, currentPlayer);
}

class GameWon extends GameState {
  final Mark winner;

  GameWon(this.winner) : super(Board(3), winner);

  @override
  List<Object> get props => [winner];
}

class GameDraw extends GameState {
  GameDraw() : super(Board(3), Mark.X);

  @override
  List<Object> get props => [];
}

class GameError extends GameState {
  final String message;

  GameError(this.message, Board board, Mark currentPlayer) : super(board, currentPlayer) {
    print(message);
  }

  @override
  List<Object> get props => [message];
}