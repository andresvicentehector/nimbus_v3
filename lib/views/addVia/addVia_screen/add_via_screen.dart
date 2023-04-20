import 'package:Nimbus/template/AppContextExtension.dart';
import 'package:flutter/material.dart';
import 'package:Nimbus/views/addVia/addVia_screen/widgets/add_via_form.dart';
import '../../z_widgets_comunes/utils/texto.dart';

class AddScreen extends StatelessWidget {
  static final String id = "AddViaScreen";
  final List<String> presas;
  const AddScreen({
    required this.presas,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarBuilder(context),
      body: _addViaBuilder(),
    );
  }

  _addViaBuilder() {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 40.0, 8.0, 10.0),
          child: AddViaForm(
            presas: presas,
          )),
    );
  }

  PreferredSizeWidget _appBarBuilder(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: texto(
          context.resources.strings.addViaScreenAppbar.toUpperCase(), context),
    );
  }
}
