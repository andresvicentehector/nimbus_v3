import 'package:flutter/material.dart';
import 'package:Nimbus/template/ConstantesPropias.dart';

import 'jugar_screen_utils.dart';

class JugarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    late final Widget kimo;
    if (version == "25") {
      kimo = kimoInfo(context);
    } else {
      kimo = Container();
    }

    return Scaffold(
        appBar: _appBarBuilder(), body: _juegosScreenBuilder(context, kimo));
  }

  _appBarBuilder() {
    return AppBar(
      title:
          Text('Juegos Disponibles', style: TextStyle(fontFamily: 'November')),
    );
  }

  _juegosScreenBuilder(BuildContext context, Widget kimo) {
    return SingleChildScrollView(
      child: Column(
        children: [dictadoInfo(context), raulinInfo(context), kimo],
      ),
    );
  }
}
