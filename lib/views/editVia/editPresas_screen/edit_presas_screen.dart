import 'package:Nimbus/viewModels/editVia/edit_presas_VM.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:Nimbus/views/editVia/update_screen/update_screen.dart';
import 'package:Nimbus/template/ConstantesPropias.dart';
import 'package:provider/provider.dart';
import '../../../models/ListadoVias/AWS/ViaAWS.dart';
import '../../z_widgets_comunes/utils/texto.dart';

import 'package:zoom_widget/zoom_widget.dart';
import 'package:Nimbus/models/ListadoVias/hive/via.dart';

class EditPresas extends StatefulWidget {
  final BluetoothDevice? server;
  final Vias via;
  const EditPresas({required this.server, required this.via});

  @override
  _EditPresas createState() => new _EditPresas();
}

class _EditPresas extends State<EditPresas> {
  EditPresasVM viewModel = EditPresasVM();

  @override
  void initState() {
    super.initState();
    viewModel.connect(widget.server, widget.via.presas);
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (viewModel.isConnected) {
      viewModel.isDisconnecting = true;
      viewModel.connection?.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    viewModel.showPresasenPared(widget.via.presas);
    final serverName = widget.server!.name ?? "Unknown";
    return ChangeNotifierProvider<EditPresasVM>(
        create: (BuildContext context) => viewModel,
        child: Consumer<EditPresasVM>(builder: (context, viewModel, _) {
          return Scaffold(
            appBar: _appBarBuilder(serverName),
            body: _wallBuilder(),
          );
        }));
  }

  _appBarBuilder(final serverName) {
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
            viewModel.navigateHome(context);
          },
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: Icon(Icons.save_sharp, color: Colors.greenAccent),
          onPressed: () async {
            viewModel.navigateUpdateVia(context, widget.via, widget.via.presas);
          },
        ),
      ],
    );
  }

  _wallBuilder() {
    return Stack(
      children: [
        /*Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage("images/fondo_trans15.png"))),
              
              //boton de editar
            )*/
        Zoom(
          backgroundColor: Color.fromARGB(255, 95, 95, 95),
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
        )
      ],
    );
  }
}
