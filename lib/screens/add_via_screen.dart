import 'package:flutter/material.dart';
import 'package:Nimbus/widgets/add_via_form.dart';

import '../widgets/utils/texto.dart';

class AddScreen extends StatelessWidget {
  final List<String> presas;
  const AddScreen({
    required this.presas,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: texto('Añadir una nueva vía'),
      ),
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
}
