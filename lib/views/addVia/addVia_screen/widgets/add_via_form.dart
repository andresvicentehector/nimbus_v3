import 'package:Nimbus/viewModels/addVia/add_viaVM.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../utils/add_via_form_utils.dart';

class AddViaForm extends StatefulWidget {
  final BluetoothDevice? server;
  final List<String> presas;
  const AddViaForm({Key? key, this.server, required this.presas})
      : super(key: key);

  @override
  _AddViaFormState createState() => _AddViaFormState();
}

class _AddViaFormState extends State<AddViaForm> {
  AddViaVM viewModel = AddViaVM();
  final _viaFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _viaFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            texto(context, "Travesía o Bloque?"),

            SizedBox(height: 27.0),

            selectorBloqueORTravesia(
                viewModel.isBloqueControler, viewModel.setBloque, context),

            SizedBox(height: 27.0),

            texto(
                context,
                "Nombra tu " +
                    (viewModel.isBloqueControler == "Bloque"
                        ? viewModel.bloque
                        : viewModel.travesia)),

            entradaFormulario(
                context, viewModel.nameController, viewModel.fieldValidator),

            SizedBox(height: 25.0),

            texto(context, '¿Quién eres?'),

            entradaFormulario(
                context, viewModel.autorController, viewModel.fieldValidator),

            SizedBox(height: 25.0),

            texto(context, 'Escoge la dificultad'),

            SizedBox(height: 25.0),

            colorPicker(viewModel.changeColor),

            SizedBox(height: 25.0),

            Divider(
              thickness: 2.0,
            ),
            SizedBox(height: 25.0),
            texto2(context, 'Explica brevemente como se hace'),

            entradaFormulario(context, viewModel.comentarioController,
                viewModel.fieldValidator),

            SizedBox(height: 27.0),

            texto2(
                context,
                "Acabas de diseñar" +
                    (viewModel.isBloqueControler == "Bloque"
                        ? " un bloque de "
                        : " una travesía de ") +
                    widget.presas.length.toString() +
                    ' presas'),

            SizedBox(height: 27.0),
            Text(
              widget.presas.join(" "),
              style:
                  DefaultTextStyle.of(context).style.apply(fontSizeFactor: 0.9),
            ),

            SizedBox(height: 25.0),

            botoneraAdd(context, _viaFormKey, viewModel.addInfo,
                widget.presas), //Botón actualizar
          ],
        ));
  }
}
