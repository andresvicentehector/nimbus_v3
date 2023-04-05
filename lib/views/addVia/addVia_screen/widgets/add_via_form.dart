import 'package:Nimbus/template/AppContextExtension.dart';
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
    viewModel.comentarioController.text =
        context.resources.strings.addViaScreenCommentTraveDescription;
    return Form(
        key: _viaFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            texto(context,
                context.resources.strings.addViaScreenTraveBloqueTittle),

            SizedBox(height: 27.0),

            selectorBloqueORTravesia(
                viewModel.isBloqueControler, viewModel.setBloque, context),

            SizedBox(height: 27.0),

            texto(
                context, context.resources.strings.addViaScreenNameTraveTittle),

            entradaFormulario(
                context, viewModel.nameController, viewModel.fieldValidator),

            SizedBox(height: 25.0),

            texto(
              context,
              context.resources.strings.addViaScreenAutorTraveTittle,
            ),

            entradaFormulario(
                context, viewModel.autorController, viewModel.fieldValidator),

            SizedBox(height: 25.0),

            texto(context,
                context.resources.strings.addViaScreenDificultyTraveTittle),

            SizedBox(height: 25.0),

            colorPicker(viewModel.changeColor),

            SizedBox(height: 25.0),

            Divider(
              thickness: 2.0,
            ),
            SizedBox(height: 25.0),
            texto2(context,
                context.resources.strings.addViaScreenCommentTraveTittle),

            entradaFormulario(context, viewModel.comentarioController,
                viewModel.fieldValidator),

            SizedBox(height: 27.0),

            texto2(
                context,
                context.resources.strings.addViaScreenNumberHolds +
                    " " +
                    widget.presas.length.toString() +
                    " " +
                    context.resources.strings.homeScreenPresas),

            /*    SizedBox(height: 27.0),
            Text(
              widget.presas.join(" "),
              style:
                  DefaultTextStyle.of(context).style.apply(fontSizeFactor: 0.9),
            ),*/

            SizedBox(height: 25.0),

            botoneraAdd(context, _viaFormKey, viewModel.addInfo,
                widget.presas), //Botón actualizar
          ],
        ));
  }
}
