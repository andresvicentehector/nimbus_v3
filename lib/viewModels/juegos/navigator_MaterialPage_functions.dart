import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../../views/bluettothSetings/widgets/ChatPage.dart';
import '../../views/juegos/games/Kimo.dart';
import '../../views/juegos/games/dictado.dart';
import '../../views/juegos/games/raulin_stones.dart';

void startChat(BuildContext context, BluetoothDevice server) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) {
        return ChatPage(server: server);
      },
    ),
  );
}

void startChatKimo(BuildContext context, BluetoothDevice server) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) {
        return ChatPageKimo(server: server);
      },
    ),
  );
}

void startDictado(BuildContext context, BluetoothDevice server) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return Dictado(server: server);
  }));
}

void startRaulin(BuildContext context, BluetoothDevice server) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return Raulin(server: server);
  }));
}
