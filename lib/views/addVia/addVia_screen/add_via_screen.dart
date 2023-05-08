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
        body: _addViaBuilder(focusNode1, focusNode2, focusNode3),
      ),
    );
  }

  _addViaBuilder(_focusNode1, _focusNode2, _focusNode3) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 40.0, 8.0, 10.0),
          child: AddViaForm(
            focusNode1: _focusNode1,
            focusNode2: _focusNode2,
            focusNode3: _focusNode3,
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
