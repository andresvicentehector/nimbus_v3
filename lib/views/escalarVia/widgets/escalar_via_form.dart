import 'package:Nimbus/viewModels/escalarVia/escalarVia_VM.dart';
import 'package:Nimbus/views/escalarVia/widgets/escalar_via_form_widgets.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:Nimbus/views/editVia/editPresas_screen/edit_presas_screen.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:provider/provider.dart';
import '../../../models/ListadoVias/AWS/ViaAWS.dart';

class EscalarVia extends StatefulWidget {
  final Vias via;
  final BluetoothDevice? server;

  const EscalarVia({
    required this.via,
    required this.server,
  });

  @override
  _EscalarViaState createState() => _EscalarViaState();
}

class _EscalarViaState extends State<EscalarVia> {
  late final _nameController;
  late final _idController;
  late final _autorController;
  late final _dificultadController;
  late final _comentarioController;
  late final _numPresasController;
  late final Box box;
  late var height;
  double width = 934;

  escalarViaVM viewModel = escalarViaVM();

  @override
  void initState() {
    super.initState();
    // Get reference to an already opened box
    box = viewModel.box;
    //print(box.keys.toString());
    //print(widget.xKey);

    _nameController = widget.via.name;
    _idController = widget.via.sId;
    _autorController = widget.via.autor;
    _dificultadController = widget.via.dificultad;
    _comentarioController = Text(widget.via.comentario);
    _numPresasController = widget.via.presas.length;
    viewModel.connect(widget.server);
  }

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
    width = MediaQuery.of(context).size.width - 20;
    viewModel.showPared(widget.via.presas);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: <Widget>[
            circulo(_dificultadController),
            SizedBox(width: 14),
            descriptivoVia(
                _nameController, _autorController, _numPresasController),
            SizedBox(width: 15),
          ],
        ),
        SizedBox(height: 20.0),
        //Text('Comentarios'),
        _comentarioController,
        SizedBox(height: 20.0),

        ChangeNotifierProvider<escalarViaVM>(
          create: (BuildContext context) => viewModel,
          child: Consumer<escalarViaVM>(builder: (context, viewModel, _) {
            return botoneraCargar(
                viewModel.isConnected, viewModel.cargarViaTroncho, widget.via);
          }),
        ),

        Divider(
          height: 24,
        ),

        esquematicoPared(width, viewModel.pared),
        Divider(
          height: 24,
        ),
        Row(children: [
          botonEditar(widget.via.isbloque!, _navigatetoEditPresas),
          SizedBox(width: 5.0),
          botonEliminar(context, _nameController, _idController,
              viewModel.cerrarConexion, viewModel.eliminarVia)
        ]),
      ],
    );
  }

  _navigatetoEditPresas() {
    viewModel.cerrarConexion();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            EditPresas(server: widget.server, via: widget.via),
      ),
    );
  }
}
