import 'package:flutter/material.dart';
import 'package:Nimbus/models/via.dart';
import 'package:Nimbus/widgets/escalar_via_form.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../widgets/utils/texto.dart';

class EscalarScreen extends StatelessWidget {
  final int xKey;
  final Via via;
  final BluetoothDevice? server;

  const EscalarScreen({
    required this.xKey,
    required this.via,
    required this.server,
  });

  @override
  Widget build(BuildContext context) {
    return _escalarFormBuilder();
  }

  Widget _escalarFormBuilder() {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: texto(
            via.name.toUpperCase(),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: EscalarVia(xKey: xKey, via: via, server: server),
          ),
        ));
  }
}
