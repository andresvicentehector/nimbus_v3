import 'package:Nimbus/template/AppContextExtension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_color_picker_wheel/models/button_behaviour.dart';
import 'package:flutter_color_picker_wheel/presets/animation_config_presets.dart';
import 'package:flutter_color_picker_wheel/widgets/flutter_color_picker_wheel.dart';
import 'package:select_form_field/select_form_field.dart';

Widget textoCabecera(String text, BuildContext context) {
  return Center(
    child: Text(text,
        textAlign: TextAlign.center,
        style: DefaultTextStyle.of(context).style.apply(
            fontFamily: context.resources.fonts.tittle, fontSizeFactor: 1.0)),
  );
}

Widget botonAnyadir(BuildContext context) {
  return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(17)),
      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: Text(context.resources.strings.editViaScreenButton,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontFamily: context.resources.fonts.tittle,
                )),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 35,
              height: 35,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_forward,
                  color: Theme.of(context).colorScheme.tertiary,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ));
}

Widget selectorBloqueTravesia(BuildContext context, String? isBloque,
    Function setBloque, String isBloqueController) {
  final List<Map<String, dynamic>> _items = [
    {
      'value': "Bloque",
      'label': context.resources.strings.addViaScreenBloqueSelection,
      //'icon': Icon(Icons.fiber_manual_record),
      'textStyle': TextStyle(color: Theme.of(context).colorScheme.primary),
    },
    {
      'value': 'Travesía',
      'label': context.resources.strings.addViaScreenTraveSelection,
      //'icon': Icon(Icons.grade),
    },
  ];
  return SelectFormField(
      type: SelectFormFieldType.dropdown,
      changeIcon: true,
      dialogTitle: 'Selecciona',
      dialogCancelBtn: 'CANCEL',
      items: _items,
      initialValue: isBloque,
      onChanged: (val) => setBloque(val),
      validator: (val) {
        isBloqueController = (val ?? isBloque)!;
        return null;
      },
      onSaved: (val) => isBloqueController = (val ?? isBloque)!);
}

Widget entradaFormulario(FocusNode focusNode, BuildContext context,
    TextEditingController controller, String? fieldValidator(String? value)) {
  return TextFormField(
    style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 0.9),

    focusNode: focusNode,
    controller: controller,
    validator: fieldValidator,
    keyboardType: TextInputType.multiline,
    minLines: 1, //Normal textInputField will be displayed
    maxLines: 10, // when user presses enter it will adapt to it
  );
}

Widget colorPicker(Function _setNewColor, dificultad) {
  return WheelColorPicker(
    onSelect: (Color newColor) {
      _setNewColor(newColor);
    },
    behaviour: ButtonBehaviour.clickToOpen,
    defaultColor: Color(dificultad),
    animationConfig: fanLikeAnimationConfig,
    colorList: const [
      [
        Colors.black,
      ],
      [Colors.pinkAccent, Colors.pink],
      [
        Colors.orangeAccent,
        Colors.orange,
      ],
      [
        Colors.yellow,
      ],
      [
        Colors.green,
      ],
    ],
    buttonSize: 80,
    pieceHeight: 18,
    innerRadius: 80,
  );
}
