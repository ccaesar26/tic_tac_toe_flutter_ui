import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe_flutter_ui/home/home.dart';

import '../../game/cubit/game_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.I<HomeCubit>(),
        ),
        BlocProvider(
          create: (context) => GetIt.I<GameCubit>(),
        )
      ],
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        bloc: GetIt.I<HomeCubit>(),
        builder: (context, state) {
          return Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.deepPurpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Tic Tac Toe',
                  style: GoogleFonts.rampartOne(
                    textStyle: const TextStyle(
                      color: Colors.white, // Set the text color to white
                      fontSize: 24.0, // Set the font size
                      fontWeight:
                          FontWeight.bold, // Set the font weight if needed
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black,
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                    ),
                  ),
                  textScaleFactor: 2.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(48.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Shadow color
                        spreadRadius: -10, // Spread radius
                        blurRadius: 7.5, // Blur radius
                        offset: const Offset(
                            0, 3), // Offset in the x and y direction
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.only(
                    top: 125.0,
                    bottom: 75.0,
                  ),
                  //constraints: const BoxConstraints.expand(),
                  child: IconButton(
                    color: Colors.yellowAccent[100],
                    onPressed: () {
                      GetIt.I<GameCubit>()
                        ..strategy = state.mode
                        ..reset();
                      Navigator.pushNamed(
                          context, '/game'); // Navigate to HomeGame
                    },
                    icon: SvgPicture.asset(
                      'assets/images/play.svg',
                      width: 175.0, // Set width to desired size
                      height: 175.0, // Set height to the same value as width
                    ),
                  ),
                ),
                DropdownButton<ModeType>(
                  icon: const Icon(
                    Icons.arrow_drop_down_rounded,
                    color: Colors.white,
                    size: 36,
                  ),
                  value: state.mode,
                  borderRadius: BorderRadius.circular(10),
                  padding: const EdgeInsets.all(24),
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Colors.white, // Set the text color to white
                      fontSize: 24.0, // Set the font size
                      fontWeight:
                          FontWeight.bold, // Set the font weight if needed
                    ),
                  ),
                  dropdownColor: Colors.deepPurpleAccent,
                  items: const <DropdownMenuItem<ModeType>>[
                    DropdownMenuItem<ModeType>(
                      value: ModeType.easy,
                      child: Text('easy'),
                    ),
                    DropdownMenuItem<ModeType>(
                      value: ModeType.medium,
                      child: Text('medium'),
                    ),
                    DropdownMenuItem<ModeType>(
                      value: ModeType.hard,
                      child: Text('hard'),
                    ),
                    DropdownMenuItem<ModeType>(
                      value: ModeType.pvp,
                      child: Text('vs a friend'),
                    ),
                  ],
                  onChanged: (ModeType? val) =>
                      GetIt.I<HomeCubit>().setMode(val ?? ModeType.easy),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
