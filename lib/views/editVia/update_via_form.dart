import 'package:flutter/material.dart';
import 'package:flutter_color_picker_wheel/models/button_behaviour.dart';
import 'package:hive/hive.dart';
import 'package:flutter_color_picker_wheel/flutter_color_picker_wheel.dart';
import 'package:Nimbus/models/ListadoVias/hive/via.dart';
import 'package:Nimbus/template/T8Colors.dart';
import 'package:select_form_field/select_form_field.dart';

import '../../models/ListadoVias/AWS/ViaAWS.dart';
import '../../viewModels/bluetoothSetings/backup_functions.dart';
import '/template/ConstantesPropias.dart';

class UpdateViaForm extends StatefulWidget {
  final String xkey;
  final Vias via;
  final List<String> presas;

  const UpdateViaForm({
    required this.xkey,
    required this.via,
    required this.presas,
  });

  @override
  _UpdateViaFormState createState() => _UpdateViaFormState();
}

class _UpdateViaFormState extends State<UpdateViaForm> {
  final _viaFormKey = GlobalKey<FormState>();

  late final _nameController;
  late final _autorController;
  late int _dificultadController;
  late final _comentarioController;
  late String _isBloqueController;
  late final Box box;
  late var height;
  final List<Map<String, dynamic>> _items = [
    {
      'value': "Bloque",
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
      return 'no puedes dejar este campo vacío';
    }
    return null;
  }

  // Update info of via box
  _updateInfo() async {
    Via newVia = Via(
        name: _nameController.text,
        autor: _autorController.text,
        dificultad: _dificultadController,
        comentario: _comentarioController.text,
        presas: widget.presas,
        isbloque: _isBloqueController,
        quepared: version == '25' ? 25 : 15);

    box.put(widget.xkey, newVia);

    //print('Info updated in box!');
  }

  @override
  void initState() {
    super.initState();
    //print(widget.xkey);
    //print("eei");
    // Get reference to an already opened box
    box = Hive.box('Viabox');
    _nameController = TextEditingController(text: widget.via.name);
    _autorController = TextEditingController(text: widget.via.autor);
    _dificultadController = widget.via.dificultad;
    _comentarioController = TextEditingController(text: widget.via.comentario);
    _isBloqueController = widget.via.isbloque!;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _viaFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          texto("Travesía o Bloque?"),
          SizedBox(height: 27.0),
          SelectFormField(
            type: SelectFormFieldType.dropdown,
            changeIcon: true,
            dialogTitle: 'Selecciona',
            dialogCancelBtn: 'CANCEL',
            items: _items,
            initialValue: widget.via.isbloque,
            onChanged: (val) => setState(() => _isBloqueController = val),
            validator: (val) {
              setState(() => _isBloqueController = val ?? widget.via.isbloque!);
              return null;
            },
            onSaved: (val) => setState(
                () => _isBloqueController = val ?? widget.via.isbloque!),
          ),

          SizedBox(height: 27.0),

          texto('Nombre ' +
              (_isBloqueController == "Bloque"
                  ? "del Bloque"
                  : "de la travesía")),
          TextFormField(
            controller: _nameController,
            validator: _fieldValidator,
          ),
          SizedBox(height: 20.0),
          texto("Autor:"),
          TextFormField(
            controller: _autorController,
            validator: _fieldValidator,
          ),
          SizedBox(height: 20.0),
          texto("Dificultad:"),
          SizedBox(height: 20.0),
          WheelColorPicker(
            onSelect: (Color newColor) {
              setState(() {
                Color c1 = newColor;
                _dificultadController = c1.value;
              });
            },
            behaviour: ButtonBehaviour.clickToOpen,
            defaultColor: Color(_dificultadController),
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
          ),
          SizedBox(height: 25.0),
          Divider(
            thickness: 2.0,
          ),
          SizedBox(height: 25.0),

          texto('Comentarios:'),
          TextFormField(
            style:
                DefaultTextStyle.of(context).style.apply(fontSizeFactor: 0.9),
            controller: _comentarioController,
            validator: _fieldValidator,
            keyboardType: TextInputType.multiline,
            minLines: 1, //Normal textInputField will be displayed
            maxLines: 10, // when user presses enter it will adapt to it
          ),
          SizedBox(height: 25.0),
          texto(widget.presas.length.toString() +
              ' Presas con su código de color:'),
          //Text('Presas: \n verde:16711680 \n rojo:65280 \n azul: 255 \n Blanco:16777215 \n amarillo:16776960 \n morado:65535'),
          SizedBox(height: 25.0),
          Text(widget.presas.toString()),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 5.0, 8.0, 104.0),
            child: Container(
              width: double.maxFinite,
              height: 50,
              child: GestureDetector(
                onTap: () async {
                  if (_viaFormKey.currentState!.validate()) {
                    await _updateInfo();
                    await createBackup(context);
                    await Navigator.pushReplacementNamed(context, '/');
                  }
                },
                child: botonAnyadir(),
              ),
            ),
          ),
        ],
      ),
    );
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

  Widget botonAnyadir() {
    return Container(
        decoration: BoxDecoration(
            color: t8_colorPrimary, borderRadius: BorderRadius.circular(16)),
        padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Center(
              child: Text("Actualizar vía",
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
}
