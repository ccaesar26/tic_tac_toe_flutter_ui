part of 'home_cubit.dart';

enum ModeType {
  easy,
  medium,
  hard,
  pvp;

  GameMode get gameMode {
    switch (this) {
      case ModeType.pvp:
        return GameMode.pvp;
      default:
        return GameMode.pve;
    }
  }

  Strategy get strategy {
    switch (this) {
      case ModeType.easy:
        return Strategy.easy;
      case ModeType.medium:
        return Strategy.medium;
      case ModeType.hard:
        return Strategy.hard;
      default:
        return Strategy.none;
    }
  }
}

final class HomeState extends Equatable {
  const HomeState({this.mode = ModeType.easy});

  final ModeType mode;

  @override
  List<Object> get props => [mode];
}
