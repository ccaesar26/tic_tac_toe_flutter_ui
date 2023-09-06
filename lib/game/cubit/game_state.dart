part of 'game_cubit.dart';

abstract class GameState extends Equatable {
  const GameState(this.board, this.currentPlayer,
      [this.milliseconds = const Duration(milliseconds: 0)]);

  final Board board;
  final Mark currentPlayer;
  final Duration milliseconds;

  @override
  List<Object> get props => [board, currentPlayer, milliseconds];
}

class GameInitial extends GameState {
  GameInitial() : super(Board(3), Mark.X);
}

class GameInProgress extends GameState {
  const GameInProgress({
    required Board board,
    required Mark currentPlayer,
    Duration remaining = const Duration(milliseconds: 0),
  }) : super(board, currentPlayer, remaining);

  @override
  List<Object> get props => [board, currentPlayer, milliseconds];
}

class GameWon extends GameState {
  final Mark winner;

  const GameWon({
    required this.winner,
    required Board board,
    required Mark currentPlayer,
    required Duration remaining,
  }) : super(board, currentPlayer, remaining);

  @override
  List<Object> get props => [winner];
}

class GameDraw extends GameState {
  const GameDraw({
    required Mark currentPlayer,
    required Board board,
    required Duration remaining,
  }) : super(board, currentPlayer, remaining);

  @override
  List<Object> get props => [];
}

class GameError extends GameState {
  final String message;

  GameError(this.message, Board board, Mark currentPlayer)
      : super(board, currentPlayer) {
    print(message);
  }

  @override
  List<Object> get props => [message];
}
