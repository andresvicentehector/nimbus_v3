import 'package:Nimbus/template/AppContextExtension.dart';
import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:flutter_color_picker_wheel/models/button_behaviour.dart';
import 'package:flutter_color_picker_wheel/presets.dart';
import 'package:flutter_color_picker_wheel/widgets/flutter_color_picker_wheel.dart';

Widget texto(
  BuildContext context,
  String text,
) {
  return Center(
    child: Text(text,
        textAlign: TextAlign.center,
        style: DefaultTextStyle.of(context).style.apply(
            fontFamily: context.resources.fonts.tittle, fontSizeFactor: 1.0)),
  );
}

Widget texto2(BuildContext context, String text) {
  return Text(text,
      textAlign: TextAlign.center,
      style: DefaultTextStyle.of(context).style.apply(
          fontFamily: context.resources.fonts.tittle, fontSizeFactor: 1.0));
}

Widget colorPicker(Function _changeColor) {
  return WheelColorPicker(
    onSelect: (Color newColor) {
      _changeColor(newColor);
    },
    behaviour: ButtonBehaviour.clickToOpen,
    defaultColor: Colors.green,
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
    innerRadius: 70,
  );
}

Widget selectorBloqueORTravesia(
    String isBloqueControler, Function setBloque, BuildContext context) {
  final List<Map<String, dynamic>> _items = [
    {
      'value': 'Bloque',
      'label': context.resources.strings.addViaScreenBloqueSelection,
      //'icon': Icon(Icons.fiber_manual_record),
      'textStyle': TextStyle(
        color: Theme.of(context).colorScheme.primary,
      ),
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
    initialValue: context.resources.strings.addViaScreenTraveSelection,
    onChanged: (val) => setBloque(val),
    validator: (val) {
      isBloqueControler = val ?? " ";
      return null;
    },
    onSaved: (val) => (isBloqueControler =
        val ?? context.resources.strings.addViaScreenTraveSelection),
  );
}

Widget botoneraAdd(BuildContext context, GlobalKey<FormState> _viaFormKey,
    Function _addInfo, List<String> presas) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 104.0),
    child: Container(
      width: double.maxFinite,
      height: 50,
      child: GestureDetector(
        onTap: () async {
          if (_viaFormKey.currentState!.validate()) {
            _addInfo(presas);

            //await createBackup(context);
            Navigator.pushReplacementNamed(context, '/');
          }
        },
        child: _estiloBotoneraAdd(context),
      ),
    ),
  );
}

Widget _estiloBotoneraAdd(BuildContext context) {
  return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(17)),
      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: Text(context.resources.strings.addViaScreenButton,
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

Widget entradaFormulario(BuildContext context, TextEditingController controller,
    String? fieldValidator(String? value)) {
  return TextFormField(
    style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 0.9),
    controller: controller,
    validator: fieldValidator,

    keyboardType: TextInputType.multiline,
    minLines: 1, //Normal textInputField will be displayed
    maxLines: 10, // when user presses enter it will adapt to it
  );
}
