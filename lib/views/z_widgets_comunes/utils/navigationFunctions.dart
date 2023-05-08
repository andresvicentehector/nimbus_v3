import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../../../models/ListadoVias/AWS/ViaAWS.dart';
import '../../addVia/addVia_screen/add_via_screen.dart';
import '../../editVia/editPresas_screen/edit_presas_screen.dart';
import '../../listadoVias/listado_screen.dart';

void navigateToListadoScreener(BuildContext context) async {
  await Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => ListadoScreen(),
      ),
      (route) => false);
}

void navigateToAddScreener(BuildContext context, List<String> presas) async {
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

void navigateToEditPresasScreener(
    BuildContext context, BluetoothConnection? connection, Vias via) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => EditPresas(connection: connection, via: via),
    ),
  );
}
