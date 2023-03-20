import 'package:flutter/material.dart';

import '../../../models/ListadoVias/AWS/ViaAWS.dart';
import '../../../template/ConstantesPropias.dart';
import '../../../template/T8Colors.dart';
import '../../../template/T8Constant.dart';
import '../../z_widgets_comunes/utils/texto.dart';

Widget circulo(dynamic _dificultadController) {
  return Container(
    decoration: BoxDecoration(
        shape: BoxShape.circle, color: Color(_dificultadController)),
    width: 120,
    height: 120,
    padding: EdgeInsets.all(10),
  );
}

Widget descriptivoVia(
    dynamic _nameController, _autorController, _numPresasController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        _nameController,
        style: TextStyle(fontSize: textSizeSMedium),
      ),
      Text(
        _autorController,
        style: TextStyle(fontFamily: fontMedium),
      ),
      Text(_numPresasController.toString() + " presas",
          style: TextStyle(fontFamily: fontMedium)),
    ],
  );
}

Widget botonCargar(bool _isConnected) {
  return Container(
      decoration: BoxDecoration(
          color: (_isConnected ? t8_colorPrimary : t8_textColorSecondary),
          borderRadius: BorderRadius.circular(5.0)),
      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: Text((_isConnected ? "Escalar" : "Conéctate a la pared"),
                style: TextStyle(
                  color: t8_white,
                  fontFamily: "November",
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
                  _isConnected ? Icons.arrow_forward : Icons.arrow_upward,
                  color: t8_white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ));
}

Widget botonEditar(String isBloque, Function _gotoEditScreen) {
  return Expanded(
    flex: 9,
    child: ElevatedButton(
      onPressed: () async {
        _gotoEditScreen();
      },
      child: Container(
          decoration: BoxDecoration(
              color: t8_colorPrimary, borderRadius: BorderRadius.circular(16)),
          padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Center(
                child: texto('Edita tu ' + isBloque),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.edit,
                      color: t8_white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          )),
    ),
  ); //boton de editar
}

Widget botonEliminar(BuildContext context, dynamic _nameController,
    Function _cerrarConexion, Function _eliminarVia) {
  return Expanded(
    flex: 3,
    child: ElevatedButton(
        onPressed: () {
          _cerrarConexion();
          showDialog(
            context: context,
            builder: (BuildContext context) => _buildPopupDialogEliminar(
                context, _nameController, _eliminarVia),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              color: t8_colorPrimary, borderRadius: BorderRadius.circular(16)),
          padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Stack(alignment: Alignment.center, children: [
            Container(
              width: 35,
              height: 35,
            ),
            Icon(Icons.delete, size: 25),
          ]),
        )),
  ); //botón de eliminar
}

Widget _buildPopupDialogEliminar(
    BuildContext context, dynamic _nameController, Function _eliminarVia) {
  return new AlertDialog(
    title: Text(_nameController.toString()),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            "Esto hará que esta via se borre para siempre y no podrás volver atrás. Estás de acuerdo?")
      ],
    ),
    actions: <Widget>[
      new ElevatedButton(
        onPressed: () async {
          _eliminarVia();
        },
        // buttonstyle:(textColor: Theme.of(context).primaryColor),
        child: const Text('Eliminar vía'),
      ),
    ],
  );
}

Widget botoneraCargar(bool isConnected, Function _cargarViaTroncho, Vias via) {
  return GestureDetector(
    onTap: () async {
      if (isConnected == true) {
        await _cargarViaTroncho(via.presas);
        ViaData = via;
        indexData = via.sId;
      }
    },
    child: botonCargar(isConnected),
  );
}

Widget esquematicoPared(double width, Widget pared) {
  return Center(
    child: GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: width,
        height: width / 1.5,
        child: Stack(
          children: <Widget>[
            // Container(color: Color.fromARGB(255, 95, 95, 95)),
            Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 95, 95, 95),
                  image: DecorationImage(
                    image: AssetImage(paredTrans),
                  )),
            ),
            pared,
          ],
        ),
      ),
    ),
  );
}
