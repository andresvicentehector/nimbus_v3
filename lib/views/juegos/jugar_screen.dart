import 'package:Nimbus/template/AppContextExtension.dart';
import 'package:Nimbus/template/colors/ColorsFixed.dart';
import 'package:flutter/material.dart';
import 'package:Nimbus/template/configuration/ConstantesPropias.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../z_widgets_comunes/navigation_bar/navigator.dart';
import 'jugar_screen_utils.dart';

class JugarScreen extends StatelessWidget {
  static final String id = 'JugarScreen';

  final BluetoothDevice? selectedDevice;

  const JugarScreen({required this.selectedDevice});
  @override
  Widget build(BuildContext context) {
    var pos = 3;
    late final Widget kimo;
    Future<Color> colorBadd = _checkIfConnection(context);

    if (version == "25") {
      kimo = kimoInfo(context);
    } else {
      kimo = Container();
    }

    return Scaffold(
        appBar: _appBarBuilder(context),
        body: _juegosScreenBuilder(context, kimo, pos, colorBadd));
  }

  _appBarBuilder(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Text(context.resources.strings.juegosScreenappbar.toUpperCase(),
          style: TextStyle(fontFamily: context.resources.fonts.tittle)),
    );
  }

  _juegosScreenBuilder(
      BuildContext context, Widget kimo, var pos, Future<Color> colorBadd) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              dictadoInfo(context),
              raulinInfo(context),
              kimo,
              SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
        Navigation(
          selectedDevice: selectedDevice,
          pos: pos,
          colorBadd: Theme.of(context).colorScheme.primary,
        )
      ],
    );
  }
}

Future<Color> _checkIfConnection(BuildContext context) async {
  Color colorBadd;
  if (await InternetConnectionChecker().hasConnection) {
    colorBadd = Theme.of(context).colorScheme.primary;
    return colorBadd;
  } else {
    //print('No hay conexión de datos');
    colorBadd = t_unactive;
    return colorBadd;
  }
}
