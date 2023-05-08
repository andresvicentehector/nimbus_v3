import 'package:Nimbus/template/AppContextExtension.dart';
import 'package:Nimbus/viewModels/addVia/add_presasVM.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';
import 'package:zoom_widget/zoom_widget.dart';

import '../../../template/configuration/ConstantesPropias.dart';
import '../../z_widgets_comunes/utils/texto.dart';

class AddPresas extends StatefulWidget {
  static final String id = "AddPresasScreen";
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

    if (viewModel.isConnecting) {
      viewModel.isDisconnecting = true;
      viewModel.connection?.dispose();
      viewModel.connection = null;
    }

    viewModel.contador = 3;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddPresasVM>(
        create: (BuildContext context) => viewModel,
        child: Consumer<AddPresasVM>(builder: (context, viewModel, _) {
          return Scaffold(
              appBar: _appBarBuilder(),
              body: Stack(children: [
                _esquemaPared(),
              ]));
        }));
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

  PreferredSizeWidget _appBarBuilder() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: (viewModel.isConnecting
          ? texto(
              context.resources.strings.addEditPresasScreenConnecting + '...',
              context)
          : viewModel.isConnected
              ? texto(context.resources.strings.addEditPresasScreenConnected,
                  context)
              : viewModel.falloConexion
                  ? texto(
                      context.resources.strings.addEditPresasScreenOfflineMode,
                      context)
                  : texto(
                      context.resources.strings.addEditPresasScreenOfflineMode,
                      context)),
      leading: Container(
          child: ElevatedButton(
        child: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () async {
          await Navigator.pushReplacementNamed(context, '/');
        },
      )),
      actions: <Widget>[
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.transparent),
            shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
          ),
          child: Icon(
            Icons.save_rounded,
            color: Theme.of(context).colorScheme.secondary,
            semanticLabel: "Guardar",
          ),
          onPressed: () async {
            if (viewModel.presas.isNotEmpty) {
              viewModel.navigatetoAddScreen(context);
            }
          },
        ),
      ],
    );
  }
}
