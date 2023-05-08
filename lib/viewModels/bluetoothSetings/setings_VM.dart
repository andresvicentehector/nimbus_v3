import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:hive/hive.dart';

import '../../views/splashScreen/splash_screen.dart';
import '../../views/z_widgets_comunes/utils/navigationFunctions.dart';
import 'changeVersion_functions.dart';

class SettingsVM extends ChangeNotifier {
  BluetoothState bluetoothState = BluetoothState.UNKNOWN;
  late final Box box;
  String address = "...";
  String name = "...";
  var isSelected = 4;
  late var width;

  Timer? discoverableTimeoutTimer;

  bool autoAcceptPairingRequests = false;

  void setBluetoothState(BluetoothState state) {
    bluetoothState = state;
    notifyListeners();
  }

  void setAdressState(String? addressA) {
    address = addressA!;
    notifyListeners();
  }

  void setBluetoothNameState(String? nameA) {
    name = nameA!;
    notifyListeners();
  }

  void setAutoAcceptPairingRequest(bool value) {
    autoAcceptPairingRequests = value;
    notifyListeners();
  }

  void navigateToListadoScreen(BuildContext context, String version) {
    changeVersion(version);

    navigateToListadoScreener(context);
  }

  void createBackup(BuildContext context) {
    createBackup(context);
  }

  void restoreBackup(BuildContext context) {
    restoreBackup(context);
  }

//TODO REMOVE IT
  void navigateToLoginScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return SplashScreen(
          title: 'Login',
        );
      },
    ));
  }
}
