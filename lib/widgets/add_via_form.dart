import 'package:flutter/material.dart';
import 'package:flutter_color_picker_wheel/models/button_behaviour.dart';
import 'package:hive/hive.dart';
import 'package:Nimbus/models/via.dart';
import 'package:flutter_color_picker_wheel/flutter_color_picker_wheel.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:Nimbus/template/T8Colors.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:Nimbus/functions/backup_functions.dart';

import '../template/ConstantesPropias.dart';

class AddViaForm extends StatefulWidget {
  final BluetoothDevice? server;
  final List<String> presas;
  const AddViaForm({Key? key, this.server, required this.presas})
      : super(key: key);

  @override
  _AddViaFormState createState() => _AddViaFormState();
}

class _AddViaFormState extends State<AddViaForm> {
  final _nameController = TextEditingController();
  final _autorController = TextEditingController();
  int _dificultadController = Colors.green.value;
  final _comentarioController = TextEditingController(
      text:
          "Todas nuestras vías siguen el método T.R.A.V.E (Tocas Rojas, Azules, Verdes y Encadenas) \n\n La salida y el top son de color blanco \n\n las amarillas se pueden usar para juntar \n\n Si con esos tres colores no es suficiente, el metodo T-R-A-V-E se puede alargar con el color morado ");
  final _viaFormKey = GlobalKey<FormState>();
  String _isBloqueControler = "";
  late var width;
  late var height;
  late final Box box;
  String bloque = "Bloque";
  String travesia = "Travesía";

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'Bloque',
      'label': 'Bloque',
      //'icon': Icon(Icons.fiber_manual_record),
      'textStyle': TextStyle(color: t8_colorPrimary),
    },
    {
      'value': 'Travesía',
      'label': 'Travesía',
      //'icon': Icon(Icons.grade),
    },
  ];

  String? _fieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo no puede quedar vacío';
    }
    return null;
  }

  // Add info to people box
  _addInfo() async {
    Via newVia = Via(
        name: _nameController.text,
        autor: _autorController.text,
        dificultad: _dificultadController,
        comentario: _comentarioController.text,
        presas: widget.presas,
        isbloque: _isBloqueControler,
        quepared: version == '25' ? 25 : 15);

    box.add(newVia);
    //print(newVia);
  }

  @override
  void initState() {
    super.initState();
    // Get reference to an already opened box
    box = Hive.box('Viabox');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _viaFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            texto("Travesía o Bloque?"),

            SizedBox(height: 27.0),

            _selectorBloqueORTravesia(),

            SizedBox(height: 27.0),

            texto("Nombra tu " +
                (_isBloqueControler == "Bloque" ? bloque : travesia)),

            _entradaFormulario(context, _nameController, _fieldValidator),

            SizedBox(height: 25.0),

            texto('¿Quién eres?'),

            _entradaFormulario(context, _autorController, _fieldValidator),

            SizedBox(height: 25.0),

            texto('Escoge la dificultad'),

            SizedBox(height: 25.0),

            _colorPicker(),

            SizedBox(height: 25.0),

            Divider(
              thickness: 2.0,
            ),
            SizedBox(height: 25.0),
            texto2('Explica brevemente como se hace'),

            _entradaFormulario(context, _comentarioController, _fieldValidator),

            SizedBox(height: 27.0),

            texto2("Acabas de diseñar" +
                (_isBloqueControler == "Bloque"
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

            _botoneraAdd(), //Botón actualizar
          ],
        ));
  }

  Widget texto(String text) {
    return Center(
      child: Text(text,
          textAlign: TextAlign.center,
          style: DefaultTextStyle.of(context)
              .style
              .apply(fontFamily: 'November', fontSizeFactor: 1.0)),
    );
  }

  Widget texto2(String text) {
    return Text(text,
        textAlign: TextAlign.center,
        style: DefaultTextStyle.of(context)
            .style
            .apply(fontFamily: 'November', fontSizeFactor: 1.0));
  }

  Widget _colorPicker() {
    return WheelColorPicker(
      onSelect: (Color newColor) {
        setState(() {
          Color c1 = newColor;
          _dificultadController = c1.value;
        });
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

  Widget _selectorBloqueORTravesia() {
    return SelectFormField(
      type: SelectFormFieldType.dropdown,
      changeIcon: true,
      dialogTitle: 'Selecciona',
      dialogCancelBtn: 'CANCEL',
      items: _items,
      initialValue: "Travesía",
      onChanged: (val) => setState(() => _isBloqueControler = val),
      validator: (val) {
        setState(() => _isBloqueControler = val ?? " ");
        return null;
      },
      onSaved: (val) => setState(() => _isBloqueControler = val ?? "Travesía"),
    );
  }

  Widget _botoneraAdd() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 104.0),
      child: Container(
        width: double.maxFinite,
        height: 50,
        child: GestureDetector(
          onTap: () async {
            if (_viaFormKey.currentState!.validate()) {
              setState(() {
                _addInfo();
              });

              await createBackup(context);
              Navigator.pushReplacementNamed(context, '/');
            }
          },
          child: _estiloBotoneraAdd(),
        ),
      ),
    );
  }

  Widget _estiloBotoneraAdd() {
    return Container(
        decoration: BoxDecoration(
            color: t8_colorPrimary, borderRadius: BorderRadius.circular(16)),
        padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Center(
              child: Text("Añadir vía",
                  style: TextStyle(
                    color: t8_white,
                    fontFamily: 'November',
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
                    color: t8_white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _entradaFormulario(BuildContext context,
      TextEditingController controller, String? fieldValidator(String? value)) {
    return TextFormField(
      style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 0.9),
      controller: controller,
      validator: fieldValidator,

      keyboardType: TextInputType.multiline,
      minLines: 1, //Normal textInputField will be displayed
      maxLines: 10, // when user presses enter it will adapt to it
    );
  }
}
