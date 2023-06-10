import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictatoe_games/providers/room_data_providers.dart';
import 'package:tictatoe_games/screens/create_room_screen.dart';
import 'package:tictatoe_games/screens/game_screen.dart';
import 'package:tictatoe_games/screens/join_room_screen.dart';
import 'package:tictatoe_games/screens/main_menu_screen.dart';
import 'package:tictatoe_games/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomDataProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
        ),
        routes: {
          MainMenuScreen.routName: (context) => const MainMenuScreen(),
          JoinRoomScreen.routName: (context) => const JoinRoomScreen(),
          CreateRoomScreen.routName: (context) => const CreateRoomScreen(),
          GameScreen.routeName: (context) => const GameScreen(),
        },
        initialRoute: MainMenuScreen.routName,
      ),
    );
  }
}
