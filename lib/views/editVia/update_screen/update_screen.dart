import 'package:Nimbus/template/AppContextExtension.dart';
import 'package:flutter/material.dart';
import '../../../models/ListadoVias/AWS/ViaAWS.dart';
import '../../z_widgets_comunes/utils/texto.dart';
import 'widgets/update_via_form.dart';

class UpdateScreen extends StatelessWidget {
  final Vias via;
  final List<String> presas;

  const UpdateScreen({required this.via, required this.presas});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarBuilder(context),
      body: _updateViaFormBuilder(),
    );
  }

  PreferredSizeWidget _appBarBuilder(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: texto(
          context.resources.strings.editViaScreenAppbar.toUpperCase(), context),
    );
  }

  Widget _updateViaFormBuilder() {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 40.0, 8.0, 10.0),
          child: SingleChildScrollView(
            child: UpdateViaForm(via: via, presas: presas),
          )),
    );
  }
}
