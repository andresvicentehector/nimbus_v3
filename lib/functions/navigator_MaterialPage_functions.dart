import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../Widgets/bluetooth/ChatPage.dart';
import '../Widgets/games/Kimo.dart';
import '../Widgets/games/dictado.dart';
import '../Widgets/games/raulin_stones.dart';

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
