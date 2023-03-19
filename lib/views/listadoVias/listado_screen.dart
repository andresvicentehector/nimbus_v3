import 'package:Nimbus/views/listadoVias/widgets/builderListadoVias.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:Nimbus/views/bluettothSetings/widgets/SelectBondedDevicePage.dart';

import 'package:Nimbus/template/ConstantesPropias.dart';
import 'package:Nimbus/views/z_widgets_comunes/navigation_bar/navigator.dart';
import '../../viewModels/ListadoVias/listado_VM.dart';
import '../z_widgets_comunes/utils/texto.dart';
import 'utils/listado_screen_utils.dart';
import '../z_widgets_comunes/navigation_bar/sidebarX.dart';
import 'package:provider/provider.dart';

class ListadoScreen extends StatefulWidget {
  static final String id = "ListadoScreen";

  @override
  _ListadoScreenState createState() => _ListadoScreenState();
}

class _ListadoScreenState extends State<ListadoScreen> {
  ViasListVM viewModel = ViasListVM();

  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    viewModel.fetchVias("25/bloque");

    viewModel.list = viewModel.raw!.values.toList();
    viewModel.list2 = viewModel.raw!.keys.toList();

    viewModel.filteredraw = viewModel.raw;
    viewModel.selectedDevice = null;
    viewModel.colorDificultad = Colors.transparent;
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViasListVM>(
        create: (BuildContext context) => viewModel,
        child: Consumer<ViasListVM>(builder: (context, viewModel, _) {
          return Scaffold(
              key: _key,
              drawer: SideBarX(
                controller: viewModel.controllerSideBar,
                filtrofunction: viewModel.filterbylevel,
              ),
              appBar: _appBarBuilder(),
              body: Stack(children: [
                Column(
                  children: [
                    botonerafiltrosSearchColor(
                        viewModel.editingController,
                        viewModel.filterbyName,
                        viewModel.quitarFiltroBloqueTrave,
                        viewModel.colorDificultad,
                        _key,
                        viewModel.filterbyblock,
                        viewModel.colorBbloque,
                        viewModel.colorBtrave,
                        viewModel.isTrave,
                        viewModel.isBloque),
                    botoneraBloqueVia(viewModel),
                  ],
                ),
                builderListadoVias(
                  via: viewModel.ViasMain.data?.vias,
                  selectedDevice: viewModel.selectedDevice,
                  status: viewModel.ViasMain.status,
                ),
                Navigation(selectedDevice: viewModel.selectedDevice),
              ]));
        }));
  }

  PreferredSizeWidget _appBarBuilder() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: texto(quePared),
      actions: <Widget>[
        ElevatedButton(
          child: Icon(Icons.bluetooth,
              color: viewModel.selectedDevice != null
                  ? Colors.blue
                  : Colors.white),
          onPressed: () async {
            viewModel.selectDevice(context);
          },
        ),
      ],
    );
  }
}
