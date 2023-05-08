import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../../models/ListadoVias/AWS/ViaAWS.dart';
import '../../template/configuration/ConstantesPropias.dart';
import '../../views/editVia/update_screen/update_screen.dart';
import '../../views/wall/add_edit_wallBuilder/wall15.dart';
import '../../views/wall/add_edit_wallBuilder/wall25.dart';

class EditPresasVM extends ChangeNotifier {
  static final clientID = 0;
  BluetoothConnection? connection;
  List<_Message> messages = List<_Message>.empty(growable: true);

  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();
  Widget pared = SizedBox.shrink();
  bool get isConnected => (connection?.isConnected ?? false);

  bool isDisconnecting = false;

  void mandarPresasAPared(
      BluetoothConnection? connection, List<String> presas) {
    if (connection != null) {
      //print('hector hemos enviao');
      sendMessage(presas.join(","));
    }
  }

  void sendMessage(String text) async {
    text = text.trim();
    textEditingController.clear();

    if (text.length > 0) {
      try {
        connection!.output.add(Uint8List.fromList(utf8.encode(text + "\r\n")));
        await connection!.output.allSent;

        messages.add(_Message(clientID, text));
        notifyListeners();
      } catch (e) {
        // Ignore error, but notify state
        notifyListeners();
      }
    }
  }

  void showPresasenPared(List<String> presas) {
    if (version == "25") {
      pared = Wall25(sendMessage: sendMessage, presas: presas);
    } else {
      pared = Wall15(sendMessage: sendMessage, presas: presas);
    }
  }

  void connectionDispose() {
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection = null;
    }
  }

  void navigateHome(BuildContext context) async {
    connectionDispose();
    await Navigator.pushReplacementNamed(context, '/');
  }

  void navigateUpdateVia(
      BuildContext context, Vias via, List<String> presas) async {
    connectionDispose();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return UpdateScreen(
            presas: presas,
            via: via,
          );
        },
      ),
    );
  }
}

class _Message {
  int whom;
  String text;
  _Message(this.whom, this.text);
}
