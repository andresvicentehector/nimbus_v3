import 'package:Nimbus/template/AppContextExtension.dart';
import 'package:flutter/material.dart';
import 'package:Nimbus/template/configuration/ConstantesPropias.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../z_widgets_comunes/navigation_bar/navigator.dart';
import 'jugar_screen_utils.dart';

class JugarScreen extends StatelessWidget {
  final BluetoothDevice? selectedDevice;

  const JugarScreen({required this.selectedDevice});
  @override
  Widget build(BuildContext context) {
    var pos = 3;
    late final Widget kimo;

    if (version == "25") {
      kimo = kimoInfo(context);
    } else {
      kimo = Container();
    }

    return Scaffold(
        appBar: _appBarBuilder(context),
        body: _juegosScreenBuilder(context, kimo, pos));
  }

  _appBarBuilder(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Text('Juegos Disponibles',
          style: TextStyle(fontFamily: context.resources.fonts.tittle)),
    );
  }

  _juegosScreenBuilder(BuildContext context, Widget kimo, var pos) {
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
        Navigation(selectedDevice: selectedDevice, pos: pos)
      ],
    );
  }
}
