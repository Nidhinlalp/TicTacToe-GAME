import 'package:flutter/material.dart';

import '../resources/socket_methods.dart';
import '../responsive/responsive.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_textfield.dart';

class JoinRoomScreen extends StatefulWidget {
  static String routName = '/join-room';
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _gameIdcontroller = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.joinRoomSuccessListener(context);
    _socketMethods.errorOccuredListener(context);
    _socketMethods.updatePlayersStateListener(context);
  }

  @override
  void dispose() {
    _gameIdcontroller.dispose();
    _namecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Resposive(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                shadow: [
                  Shadow(
                    blurRadius: 40,
                    color: Colors.blue,
                  ),
                ],
                text: 'Join Room',
                fontSize: 70,
              ),
              SizedBox(height: size.height * 0.08),
              CustomTextField(
                controller: _namecontroller,
                hintText: 'Enter your nickname',
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _gameIdcontroller,
                hintText: 'Enter game id',
              ),
              SizedBox(height: size.height * 0.045),
              CustomButton(
                onTap: () => _socketMethods.joinRoom(
                  _namecontroller.text.trim(),
                  _gameIdcontroller.text.trim(),
                ),
                text: 'Join',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
