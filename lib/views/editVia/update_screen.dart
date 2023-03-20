import 'package:flutter/material.dart';
import 'package:Nimbus/models/ListadoVias/hive/via.dart';

import '../../models/ListadoVias/AWS/ViaAWS.dart';
import '../z_widgets_comunes/utils/texto.dart';
import 'update_via_form.dart';

class UpdateScreen extends StatelessWidget {
  final String xkey;
  final Vias via;
  final List<String> presas;

  const UpdateScreen({
    required this.xkey,
    required this.via,
    required this.presas,
  });

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBarBuilder(),
      body: _updateViaFormBuilder(),
    );
  }

  PreferredSizeWidget _appBarBuilder() {
    return AppBar(
      title: texto(
        'Actualizar una via',
      ),
    );
  }

  Widget _updateViaFormBuilder() {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 40.0, 8.0, 10.0),
          child: SingleChildScrollView(
            child: UpdateViaForm(xkey: xkey, via: via, presas: presas),
          )),
    );
  }
}
