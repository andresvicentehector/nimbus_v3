import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../../template/configuration/ConstantesPropias.dart';
import '../../views/addVia/addVia_screen/add_via_screen.dart';
import '../../views/wall/add_edit_wallBuilder/wall15.dart';
import '../../views/wall/add_edit_wallBuilder/wall25.dart';

class AddPresasVM extends ChangeNotifier {
  static final clientID = 0;
  BluetoothConnection? connection;
  List<String> presas = [];
  List<_Message> messages = List<_Message>.empty(growable: true);
  String _messageBuffer = '';
  Widget pared = SizedBox.shrink();
  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();
  bool isConnecting = true;
  bool get isConnected => (connection?.isConnected ?? false);
  bool isDisconnecting = false;
  bool falloConexion = false;

  int contador = 0;

  Future<void> connect(BluetoothDevice? server) async {
    if (server == null) {
      isConnecting = false;
    } else {
      BluetoothConnection.toAddress(server.address).then((_connection) {
        //print('Connected to the device');
        connection = _connection;
        if (presas.isEmpty) {
          _sendMessage('clear');
          print('Que se le envia: se le envía un clear');
        } else {
          _sendMessage(presas.join(","));
          print('Que se le envia:' + presas.join(","));
        }
        notifyListeners();
        isConnecting = false;
        isDisconnecting = false;

        connection!.input!.listen(_onDataReceived).onDone(() {
          // Example: Detect which side closed the connection
          // There should be `isDisconnecting` flag to show are we are (locally)
          // in middle of disconnecting process, should be set before calling
          // `dispose`, `finish` or `close`, which all causes to disconnect.
          // If we except the disconnection, `onDone` should be fired as result.
          // If we didn't except this (no flag set), it means closing by remote.
          if (isDisconnecting) {
            print('Disconnecting locally!');
            isConnecting = false;
            falloConexion = true;
          } else {
            print('Disconnected remotely!');
            isConnecting = false;
            falloConexion = true;
            reconnect(server);
            notifyListeners();
          }
          notifyListeners();
        });
      }).catchError((e) {
        print('Cannot connect, exception occured');
        //print(e);
        isConnecting = false;
        if (contador >= 3) {
          falloConexion = true;
          notifyListeners();
        } else {
          reconnect(server);
          notifyListeners();
        }
        contador++;
      });
    }
  }

  Future<void> reconnect(BluetoothDevice? server) async {
    if (isConnected) {
      return;
    }

    if (server == null) {
      return;
    }

    try {
      print('reconecting');
      isConnecting = true;
      await connect(server);
    } catch (e) {
      throw e;
    }
  }

  Future<void> reconnectandSendPresas(BluetoothDevice? server) async {
    if (isConnected) {
      return;
    }

    if (server == null) {
      return;
    }

    try {
      print('reconecting');
      isConnecting = true;
    } catch (e) {
      throw e;
    }
  }

  void setPared() {
    if (version == "25") {
      pared = Wall25(sendMessage: _sendMessage, presas: presas);
    } else {
      pared = Wall15(sendMessage: _sendMessage, presas: presas);
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

  void _sendMessage(String text) async {
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

  void navigatetoAddScreen(BuildContext context) async {
    connection?.dispose();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return AddScreen(
            presas: presas,
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
