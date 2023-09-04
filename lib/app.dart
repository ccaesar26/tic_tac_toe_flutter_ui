import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:tic_tac_toe_flutter_ui/game/cubit/game_cubit.dart';
import 'package:tic_tac_toe_flutter_ui/game/game.dart';
import 'package:tic_tac_toe_flutter_ui/home/home.dart';

class TicTacToeApp extends StatelessWidget {
  TicTacToeApp({super.key}) {
    GetIt.I.registerSingleton<GameCubit>(GameCubit());
    GetIt.I.registerSingleton<HomeCubit>(HomeCubit());
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const HomePage());
      case '/game':
        // GetIt.I<GameCubit>().reset();
        // GetIt.I<GameCubit>().strategy = settings.arguments as ModeType;
        return MaterialPageRoute(builder: (context) =>  GamePage());
      default:
      // Handle unknown routes here
        return MaterialPageRoute(builder: (context) => const NotFoundPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: generateRoute,
    );
  }
}

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Not Found'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 50),
            const SizedBox(height: 20),
            const Text(
              'Page Not Found',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to the previous screen
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
