import 'dart:convert';
import 'dart:typed_data';
import 'package:Nimbus/viewModels/addVia/add_presasVM.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:Nimbus/views/addVia/addVia_screen/add_via_screen.dart';

import 'package:zoom_widget/zoom_widget.dart';
import 'package:Nimbus/template/ConstantesPropias.dart';

import '../z_widgets_comunes/utils/texto.dart';

class AddPresas extends StatefulWidget {
  final BluetoothDevice? server;

  const AddPresas({required this.server});

  @override
  _AddPresas createState() => new _AddPresas();
}

class _AddPresas extends State<AddPresas> {
  AddPresasVM viewModel = AddPresasVM();
  @override
  void initState() {
    super.initState();
    viewModel.connect(widget.server);
    viewModel.setPared();
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (viewModel.isConnected) {
      viewModel.isDisconnecting = true;
      viewModel.connection?.dispose();
      viewModel.connection = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final serverName = widget.server!.name ?? "Unknown";

    return Scaffold(
        appBar: _appBarBuilder(serverName),
        body: Stack(children: [
          _esquemaPared(),
        ]));
  }

  Widget _esquemaPared() {
    return Zoom(
      backgroundColor: Color.fromARGB(255, 95, 95, 95),
      colorScrollBars: Colors.transparent,
      initTotalZoomOut: true,
      doubleTapZoom: false,
      canvasColor: Color.fromARGB(255, 95, 95, 95),
      child: SizedBox(
        width: 936,
        height: 624,
        child: Stack(
          children: <Widget>[
            Container(color: Color.fromARGB(255, 95, 95, 95)),
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(paredTrans),
              )),
            ),
            viewModel.pared,
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _appBarBuilder(final serverName) {
    return AppBar(
      title: (viewModel.isConnecting
          ? texto('Conectando con ' + serverName + '...')
          : viewModel.isConnected
              ? texto('Elige las presas')
              : texto('Envía presas a ' + serverName)),
      leading: Container(
          child: ElevatedButton(
        child: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () async {
          viewModel.connection?.dispose();
          await Navigator.pushReplacementNamed(context, '/');
        },
      )),
      actions: <Widget>[
        ElevatedButton(
          child: Icon(
            Icons.save_rounded,
            color: Colors.greenAccent,
            semanticLabel: "Guardar",
          ),
          onPressed: () async {
            viewModel.navigatetoAddScreen(context);
          },
        ),
      ],
    );
  }
}
