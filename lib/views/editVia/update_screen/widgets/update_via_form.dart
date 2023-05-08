import 'package:Nimbus/template/AppContextExtension.dart';
import 'package:Nimbus/viewModels/editVia/update_screen_VM.dart';
import 'package:Nimbus/views/editVia/update_screen/utils/update_via_form_utils.dart';
import 'package:flutter/material.dart';

import '../../../../models/ListadoVias/AWS/ViaAWS.dart';
import '../../../../viewModels/bluetoothSetings/backup_functions.dart';
import '../../../z_widgets_comunes/utils/navigationFunctions.dart';

class UpdateViaForm extends StatefulWidget {
  final Vias via;
  final List<String> presas;
  final focusNode1;
  final focusNode2;
  final focusNode3;

  const UpdateViaForm(
      {required this.via,
      required this.presas,
      this.focusNode1,
      this.focusNode2,
      this.focusNode3});

  @override
  _UpdateViaFormState createState() => _UpdateViaFormState();
}

class _UpdateViaFormState extends State<UpdateViaForm> {
  final _viaFormKey = GlobalKey<FormState>();
  UpdateScreenVM viewModel = UpdateScreenVM();

  late var height;

  @override
  void initState() {
    super.initState();

    viewModel.nameController = TextEditingController(text: widget.via.name);
    viewModel.autorController = TextEditingController(text: widget.via.autor);
    viewModel.dificultadController = widget.via.dificultad;
    viewModel.comentarioController =
        TextEditingController(text: widget.via.comentario);
    viewModel.isBloqueController = widget.via.isbloque!;
  }

  void dispose() {
    super.dispose();
    widget.focusNode1.dispose();
    widget.focusNode2.dispose();
    widget.focusNode3.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _viaFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textoCabecera(
              context.resources.strings.editViaScreenTraveBloqueTittle,
              context),
          SizedBox(height: 27.0),

          selectorBloqueTravesia(context, widget.via.isbloque,
              viewModel.setBloque, viewModel.isBloqueController),

          SizedBox(height: 27.0),

          textoCabecera(
              context.resources.strings.editViaScreenNameTraveTittle +
                  (viewModel.isBloqueController == "Bloque"
                      ? context.resources.strings
                              .addViaScreenDELBloqueSelection +
                          context.resources.strings.editViaScreenBloqueSelection
                      : context.resources.strings
                              .addViaScreenDELATraveSelection +
                          context
                              .resources.strings.editViaScreenTraveSelection),
              context),

          entradaFormulario(widget.focusNode1, context,
              viewModel.nameController, viewModel.fieldValidator),

          SizedBox(height: 20.0),
          textoCabecera(
              context.resources.strings.editViaScreenBAutorTraveTittle,
              context),

          entradaFormulario(widget.focusNode2, context,
              viewModel.autorController, viewModel.fieldValidator),
          SizedBox(height: 20.0),
          textoCabecera(
              context.resources.strings.editViaScreenDificultyTraveTittle,
              context),
          SizedBox(height: 20.0),

          colorPicker(viewModel.setNewColor, widget.via.dificultad),

          SizedBox(height: 25.0),

          Divider(
            thickness: 2.0,
          ),
          SizedBox(height: 25.0),

          textoCabecera(
              context.resources.strings.editViaScreenCommentTraveTittle,
              context),

          entradaFormulario(widget.focusNode3, context,
              viewModel.comentarioController, viewModel.fieldValidator),

          SizedBox(height: 25.0),
          textoCabecera(
              widget.via.presas.length.toString() +
                  ' ' +
                  context.resources.strings.editViaScreenNumberHolds,
              context),
          //Text('Presas: \n verde:16711680 \n rojo:65280 \n azul: 255 \n Blanco:16777215 \n amarillo:16776960 \n morado:65535'),
          SizedBox(height: 25.0),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 104.0),
            child: Container(
              width: double.maxFinite,
              height: 50,
              child: GestureDetector(
                onTap: () async {
                  if (_viaFormKey.currentState!.validate()) {
                    await viewModel.updateInfo(
                        viewModel.nameController.text.trimRight(),
                        viewModel.autorController.text.trimRight(),
                        viewModel.dificultadController,
                        viewModel.comentarioController.text.trimRight(),
                        viewModel.isBloqueController,
                        widget.via.presas,
                        widget.via.sId!);
                    await createBackup(context);
                    navigateToListadoScreener(context);
                  }
                },
                child: botonAnyadir(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
