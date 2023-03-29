import 'package:flutter/material.dart';
import 'package:Nimbus/views/escalarVia/widgets/escalar_via_form.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import '../../models/ListadoVias/AWS/ViaAWS.dart';
import '../z_widgets_comunes/utils/texto.dart';

class EscalarScreen extends StatelessWidget {
  final Vias via;
  final BluetoothDevice? server;

  const EscalarScreen({
    required this.via,
    required this.server,
  });

  @override
  Widget build(BuildContext context) {
    return _escalarFormBuilder(context);
  }

  Widget _escalarFormBuilder(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: texto(via.name!.toUpperCase(), context),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: EscalarVia(via: via, server: server),
          ),
        ));
  }
}
