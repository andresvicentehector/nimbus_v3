import 'package:Nimbus/template/AppContextExtension.dart';
import 'package:flutter/material.dart';
import '../../../models/ListadoVias/AWS/ViaAWS.dart';
import '../../z_widgets_comunes/utils/texto.dart';
import 'widgets/update_via_form.dart';

class UpdateScreen extends StatelessWidget {
  static final String id = 'UpdateScreen';
  final Vias via;
  final List<String> presas;

  const UpdateScreen({required this.via, required this.presas});

  Widget build(BuildContext context) {
    final focusNode1 = FocusNode();
    final focusNode2 = FocusNode();
    final focusNode3 = FocusNode();
    return GestureDetector(
      onTap: () {
        focusNode1.unfocus();
        focusNode2.unfocus();
        focusNode3.unfocus();
      },
      child: Scaffold(
        appBar: _appBarBuilder(context),
        body: _updateViaFormBuilder(focusNode1, focusNode2, focusNode3),
      ),
    );
  }

  PreferredSizeWidget _appBarBuilder(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: texto(
          context.resources.strings.editViaScreenAppbar.toUpperCase(), context),
    );
  }

  Widget _updateViaFormBuilder(
    focusNode1,
    focusNode2,
    focusNode3,
  ) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 40.0, 8.0, 10.0),
          child: SingleChildScrollView(
            child: UpdateViaForm(
                focusNode1: focusNode1,
                focusNode2: focusNode2,
                focusNode3: focusNode3,
                via: via,
                presas: presas),
          )),
    );
  }
}
