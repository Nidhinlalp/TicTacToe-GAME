import 'package:flutter/material.dart';
import 'package:tictatoe_games/responsive/responsive.dart';
import 'package:tictatoe_games/screens/join_room_screen.dart';
import 'package:tictatoe_games/widgets/custom_button.dart';

import 'create_room_screen.dart';

class MainMenuScreen extends StatelessWidget {
  static String routName = '/main-menu';
  const MainMenuScreen({super.key});

  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomScreen.routName);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScreen.routName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Resposive(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              onTap: () => createRoom(context),
              text: 'Create Room',
            ),
            const SizedBox(height: 20),
            CustomButton(
              onTap: () => joinRoom(context),
              text: 'Join Room',
            ),
          ],
        ),
      ),
    );
  }
}
