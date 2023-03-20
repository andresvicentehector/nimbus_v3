import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../data/response/ApiResponse.dart';
import '../../models/ListadoVias/AWS/ViaAWS.dart';
import '../../repository/vias/ViaRepoImp.dart';
import '../../views/editVia/edit_presas_screen.dart';

class escalarViaVM extends ChangeNotifier {
  final _myRepo = ViaRepoImp();
  ApiResponse<ViaAWS> ViasMain = ApiResponse.loading();

  static final clientID = 0;
  BluetoothConnection? connection;

  final box = Hive.box('Viabox');

  List<_Message> messages = List<_Message>.empty(growable: true);
  String _messageBuffer = '';

  final TextEditingController textEditingController =
      new TextEditingController();
  //final ScrollController listScrollController = new ScrollController();

  bool isConnecting = true;
  bool get isConnected => (connection?.isConnected ?? false);

  bool isDisconnecting = false;
  late Widget pared;

  void _setViasMain(ApiResponse<ViaAWS> response) {
    //print("Response :: $response");
    ViasMain = response;
    notifyListeners();
  }

  //the only way to access to movie list from the ui
  Future<void> erraseVia(String id) async {
    print("id " + id);
    if (await InternetConnectionChecker().hasConnection) {
      _setViasMain(ApiResponse.loading());

      _myRepo
          .deleteVia(id)
          .then((value) => _setViasMain(ApiResponse.completed(value)))
          .onError((error, stackTrace) =>
              _setViasMain(ApiResponse.error(error.toString())));
    } else {
      // fetchViasFromHive();
    }
  }

  void connect(BluetoothDevice? server) {
    BluetoothConnection.toAddress(server!.address).then((_connection) {
      //print('Connected to the device');
      connection = _connection;

      isConnecting = false;
      isDisconnecting = false;

      connection!.input!.listen(_onDataReceived).onDone(() {
        if (isDisconnecting) {
          //print('Disconnecting locally!');
        } else {
          //print('Disconnected remotely!');
        }

        notifyListeners();
      });
    }).catchError((error) {
      //print('Cannot connect, exception occured');
      //print(error);
    });
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
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
    notifyListeners();
  }

  Future _sendMessage(String text) async {
    text = text.trim();
    textEditingController.clear();

    if (text.length > 0) {
      try {
        connection!.output.add(Uint8List.fromList(utf8.encode(text + "\r\n")));
        await connection!.output.allSent;

        messages.add(_Message(clientID, text));
      } catch (e) {
        // Ignore error, but notify state
      }
    }
    notifyListeners();
  }

  Future cargarViaTroncho(List<String> presas) async {
    String troncho = presas.join(",");
    // await _sendMessage("clear");
    // sleep(new Duration(seconds:1));
    await _sendMessage(troncho + ", ");
    //sleep(new Duration(seconds:2));
    //print(troncho + ", ");
  }

  void cerrarConexion() {
    connection?.dispose();
    notifyListeners();
  }

  void eliminarVia(BuildContext context) async {
    //  await box.delete(widget.xKey);

    cerrarConexion();

    ///TODO ELIMINAR VIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    await Navigator.pushReplacementNamed(context, '/');
  }
}

class _Message {
  int whom;
  String text;

  _Message(this.whom, this.text);
}
