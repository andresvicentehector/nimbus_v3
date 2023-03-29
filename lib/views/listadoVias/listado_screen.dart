import 'package:Nimbus/views/listadoVias/widgets/builderListadoVias.dart';
import 'package:flutter/material.dart';
import 'package:Nimbus/views/z_widgets_comunes/navigation_bar/navigator.dart';
import '../../template/configuration/ConstantesPropias.dart';
import '../../viewModels/ListadoVias/listado_VM.dart';
import '../z_widgets_comunes/utils/texto.dart';
import 'utils/listado_screen_utils.dart';
import 'widgets/sidebarX.dart';
import 'package:provider/provider.dart';

class ListadoScreen extends StatefulWidget {
  static final String id = "ListadoScreen";

  @override
  _ListadoScreenState createState() => _ListadoScreenState();
}

class _ListadoScreenState extends State<ListadoScreen> {
  ViasListVM viewModel = ViasListVM();
  final _key = GlobalKey<ScaffoldState>();
  var pos = 1;

  @override
  void initState() {
    super.initState();

    viewModel.fetchVias("listar?quepared=" + version);
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
                        context,
                        viewModel.colorBbloque,
                        viewModel.colorBtrave,
                        viewModel.isTrave,
                        viewModel.isBloque),
                    botoneraBloqueVia(viewModel, context),
                  ],
                ),
                BuilderListadoVias(
                  via: viewModel.viasMain.data?.vias,
                  selectedDevice: viewModel.selectedDevice,
                  status: viewModel.viasMain.status,
                  message: viewModel.viasMain.message,
                ),
                Navigation(selectedDevice: viewModel.selectedDevice, pos: pos),
              ]));
        }));
  }

  PreferredSizeWidget _appBarBuilder() {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      automaticallyImplyLeading: false,
      title: texto(quePared, context),
      actions: <Widget>[
        ElevatedButton(
          style: ButtonStyle(),
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
