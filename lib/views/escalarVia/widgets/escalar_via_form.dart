import 'package:Nimbus/viewModels/escalarVia/escalarVia_VM.dart';
import 'package:Nimbus/views/escalarVia/widgets/escalar_via_form_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:Nimbus/views/editVia/editPresas_screen/edit_presas_screen.dart';

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
  late var height;
  double width = 934;

  EscalarViaVM viewModel = EscalarViaVM();

  @override
  void initState() {
    super.initState();
    viewModel.connect(widget.server);
    _nameController = widget.via.name;
    _idController = widget.via.sId;
    _autorController = widget.via.autor;
    _dificultadController = widget.via.dificultad;
    _comentarioController = Text(widget.via.comentario);
    _numPresasController = widget.via.presas.length;
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
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: <Widget>[
              circulo(_dificultadController),
              SizedBox(width: 14),
              descriptivoVia(_nameController, _autorController,
                  _numPresasController, context),
              SizedBox(width: 15),
            ],
          ),
          SizedBox(height: 20.0),
          //Text('Comentarios'),
          _comentarioController,
          SizedBox(height: 20.0),

          ChangeNotifierProvider<EscalarViaVM>(
            create: (BuildContext context) => viewModel,
            child: Consumer<EscalarViaVM>(builder: (context, viewModel, _) {
              return botoneraCargar(viewModel.isConnected,
                  viewModel.cargarViaTroncho, widget.via, context);
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
            botonEditar(widget.via.isbloque!, _navigatetoEditPresas, context),
            SizedBox(width: 5.0),
            botonEliminar(context, _nameController, _idController,
                viewModel.cerrarConexion, viewModel.eliminarVia)
          ]),
        ],
      ),
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
