import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tictatoe_games/providers/room_data_providers.dart';
import 'package:tictatoe_games/resources/socket_client.dart';
import 'package:tictatoe_games/screens/game_screen.dart';
import 'package:tictatoe_games/utils/utils.dart';

import 'game_methods.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  Socket get socketClient => _socketClient;

  // EMMITS
  void createRoom(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit('createRoom', {
        'nickname': nickname,
      });
    }
  }

  //JOIN
  void joinRoom(String nickname, String roomId) {
    if (nickname.isNotEmpty && roomId.isNotEmpty) {
      _socketClient.emit('joinRoom', {
        'nickname': nickname,
        'roomId': roomId,
      });
    }
  }

  void tapGrid(int index, String roomId, List<String> displayElements) {
    if (displayElements[index] == '') {
      _socketClient.emit('tap', {
        'index': index,
        'roomId': roomId,
      });
    }
  }

  // LISTENERS
  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on('createRoomSuccess', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient.on('joinRoomSuccess', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void errorOccuredListener(BuildContext context) {
    _socketClient.on('errorOccurred', (data) {
      showSnackBar(context, data);
    });
  }

  //FUNCTION
  void updatePlayersStateListener(BuildContext context) {
    _socketClient.on('updatePlayers', (playerData) {
      Provider.of<RoomDataProvider>(context, listen: false).updatePLayer1(
        playerData[0],
      );
      Provider.of<RoomDataProvider>(context, listen: false).updatePLayer2(
        playerData[1],
      );
    });
  }

  void updateRoomListener(BuildContext context) {
    _socketClient.on('updateRoom', (data) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(data);
    });
  }

  void tappedListener(BuildContext context) {
    _socketClient.on('tapped', (data) {
      RoomDataProvider roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);
      roomDataProvider.updateDisplayElements(
        data['index'],
        data['choice'],
      );
      roomDataProvider.updateRoomData(data['room']);
      // check winnner
      GameMethods().checkWinner(context, _socketClient);
    });
  }

  void pointIncreaseListener(BuildContext context) {
    _socketClient.on('pointIncrease', (playerData) {
      var roomDataProvider =
          Provider.of<RoomDataProvider>(context, listen: false);

      if (playerData['socketID'] == roomDataProvider.player1.socketID) {
        roomDataProvider.updatePLayer1(playerData);
      } else {
        roomDataProvider.updatePLayer2(playerData);
      }
    });
  }

  void endGameListener(BuildContext context) {
    _socketClient.on('endGame', (playerData) {
      showGameDialog(context, '${playerData['nickname']} won the game!');
      Navigator.popUntil(context, (route) => false);
    });
  }
}
