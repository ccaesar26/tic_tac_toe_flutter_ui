import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe_flutter_ui/game/cubit/game_cubit.dart';
import 'package:tic_tac_toe_lib/tic_tac_toe_lib.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const GameView();
  }
}

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<GameCubit, GameState>(
        bloc: GetIt.I<GameCubit>(),
        listenWhen: (prev, curr) =>
            prev is GameInProgress && (curr is GameWon || curr is GameDraw),
        listener: (context, state) {
          if (state is GameWon || state is GameDraw) {
            showDialog<void>(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) => WillPopScope(
                onWillPop: () async => false,
                child: AlertDialog(
                  content: Text(
                    'Game Over!\nDo you want to play again?',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  icon: SvgPicture.asset(
                    'assets/images/game_over.svg',
                    width: 150,
                    height: 150,
                  ),
                  backgroundColor: Colors.yellow[400],
                  actions: <Widget>[
                    TextButton(
                      child: const Text(
                        'Yes',
                        style: TextStyle(
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                      onPressed: () {
                        GetIt.I<GameCubit>().reset();
                        Navigator.pop(context, 'Yes');
                      },
                    ),
                    TextButton(
                        child: const Text(
                          'No',
                          style: TextStyle(
                            color: Colors.deepPurpleAccent,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context, 'No');
                          Navigator.pop(context);
                        }),
                  ],
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.deepPurple,
              body: Container(
                constraints: const BoxConstraints.expand(),
                child: Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Current Player:',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            width: 52,
                            height: 52,
                            padding: const EdgeInsets.only(
                              top: 8.0,
                              bottom: 12.0,
                              left: 8.0,
                              right: 8.0,
                            ),
                            child: SvgPicture.asset(
                              'assets/images/${state.currentPlayer.toString().toLowerCase()}.svg',
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 320,
                        height: 360,
                        margin: const EdgeInsets.symmetric(
                          vertical: 24,
                          horizontal: 0,
                        ),
                        child: GridView(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          children: List.generate(9, (index) {
                            final border = _getBorder(index);
                            final mark = state.board.at(index ~/ 3, index % 3);
                            return GestureDetector(
                              onTap: () {
                                GetIt.I<GameCubit>()
                                    .makeMark(Position(index ~/ 3, index % 3));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: border,
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/images/${mark.toString().toLowerCase()}.svg',
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 42,
                        ),
                        child: Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 64,
                              height: 64,
                              margin: const EdgeInsets.all(18.0),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.yellow,
                                    Colors.yellow.shade700,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  GetIt.I<GameCubit>().reset();
                                },
                                icon: SvgPicture.asset(
                                  'assets/images/reset.svg',
                                  width: 54,
                                  height: 54,
                                ),
                              ),
                            ),
                            Container(
                              width: 96,
                              height: 96,
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.yellow,
                                    Colors.yellow.shade700,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: SvgPicture.asset(
                                  'assets/images/home.svg',
                                  width: 86,
                                  height: 86,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 100,
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                    ]),
              ));
        },
      ),
    );
  }
}

Border _getBorder(int index) {
  switch (index) {
    case 0:
    case 3:
      return const Border(
        bottom: BorderSide(width: 3.0, color: Colors.white),
        right: BorderSide(width: 3.0, color: Colors.white),
      );
    case 1:
    case 4:
      return const Border(
        bottom: BorderSide(width: 3.0, color: Colors.white),
      );
    case 2:
    case 5:
      return const Border(
        bottom: BorderSide(width: 3.0, color: Colors.white),
        left: BorderSide(width: 3.0, color: Colors.white),
      );
    case 6:
      return const Border(
        right: BorderSide(width: 3.0, color: Colors.white),
      );
    case 8:
      return const Border(
        left: BorderSide(width: 3.0, color: Colors.white),
      );
    default:
      return const Border();
  }
}
