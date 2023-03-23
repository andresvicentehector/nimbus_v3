import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../../models/ListadoVias/AWS/ViaAWS.dart';
import '../../template/ConstantesPropias.dart';
import '../../views/editVia/update_screen/update_screen.dart';
import '../../views/z_widgets_comunes/wall/add_edit_wallBuilder/wall15.dart';
import '../../views/z_widgets_comunes/wall/add_edit_wallBuilder/wall25.dart';

class EditPresasVM extends ChangeNotifier {
  static final clientID = 0;
  BluetoothConnection? connection;
  List<_Message> messages = List<_Message>.empty(growable: true);
  String _messageBuffer = '';

  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();
  Widget pared = SizedBox.shrink();
  bool isConnecting = true;
  bool get isConnected => (connection?.isConnected ?? false);

  bool isDisconnecting = false;

  void connect(BluetoothDevice? server, List<String> presas) {
    BluetoothConnection.toAddress(server!.address).then((_connection) {
      //print('Connected to the device');

      connection = _connection;
      sendMessage(presas.join(","));

      isConnecting = false;
      isDisconnecting = false;
      notifyListeners();

      connection!.input!.listen(_onDataReceived).onDone(() {
        // Example: Detect which side closed the connection
        // There should be `isDisconnecting` flag to show are we are (locally)
        // in middle of disconnecting process, should be set before calling
        // `dispose`, `finish` or `close`, which all causes to disconnect.
        // If we except the disconnection, `onDone` should be fired as result.
        // If we didn't except this (no flag set), it means closing by remote.
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
        notifyListeners();
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
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

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      messages.add(
        _Message(
          1,
          backspacesCounter > 0
              ? _messageBuffer.substring(
                  0, _messageBuffer.length - backspacesCounter)
              : _messageBuffer + dataString.substring(0, index),
        ),
      );
      _messageBuffer = dataString.substring(index);
      notifyListeners();
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
  }

  void connectionDispose() {
    connection?.dispose();
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
