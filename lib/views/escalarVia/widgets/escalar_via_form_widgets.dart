import "package:Nimbus/template/AppContextExtension.dart";
import 'package:Nimbus/template/colors/ColorsFixed.dart';
import 'package:flutter/material.dart';
import '../../../models/ListadoVias/AWS/ViaAWS.dart';
import '../../../template/configuration/ConstantesPropias.dart';

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

Widget descriptivoVia(dynamic _nameController, _autorController,
    _numPresasController, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        _nameController,
        style: TextStyle(
            color: Theme.of(context).colorScheme.tertiaryContainer,
            fontSize: context.resources.dimensions.textSizeSMedium),
      ),
      Text(
        _autorController,
        style: TextStyle(fontFamily: context.resources.fonts.fontMedium),
      ),
      Text(
          _numPresasController.toString() +
              context.resources.strings.homeScreenPresas,
          style: TextStyle(fontFamily: context.resources.fonts.fontMedium)),
    ],
  );
}

Widget botonCargar(bool _isConnected, BuildContext context) {
  return Container(
      decoration: BoxDecoration(
          color: (_isConnected
              ? Theme.of(context).colorScheme.primary
              : t_unactive),
          borderRadius: BorderRadius.circular(5.0)),
      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: Text(
                (_isConnected
                    ? context.resources.strings.escalarViaScreenButtonClimb
                    : context.resources.strings.escalarViaScreenButtonConnect),
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
                  _isConnected ? Icons.arrow_forward : Icons.arrow_upward,
                  color: Theme.of(context).colorScheme.tertiary,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ));
}

Widget botonEditar(
    String isBloque, Function _gotoEditScreen, BuildContext context) {
  return Expanded(
    flex: 9,
    child: ElevatedButton(
      onPressed: () async {
        _gotoEditScreen();
      },
      child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(16)),
          padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Center(
                  child: texto(
                      context.resources.strings.escalarViaScreenButtonEdit +
                          (isBloque == "Bloque"
                              ? context.resources.strings
                                  .editViaScreenBloqueSelection
                              : context.resources.strings
                                  .editViaScreenTraveSelection),
                      context)),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.edit,
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
    dynamic _idController, Function _cerrarConexion, Function _eliminarVia) {
  return Expanded(
    flex: 3,
    child: ElevatedButton(
        onPressed: () {
          _cerrarConexion();
          showDialog(
            context: context,
            builder: (BuildContext context) => _buildPopupDialogEliminar(
                context, _nameController, _idController, _eliminarVia),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(16)),
          padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Stack(alignment: Alignment.center, children: [
            Container(
              width: 35,
              height: 35,
            ),
            Icon(Icons.delete,
                color: Theme.of(context).colorScheme.tertiary, size: 25),
          ]),
        )),
  ); //botón de eliminar
}

Widget _buildPopupDialogEliminar(BuildContext context, dynamic _nameController,
    dynamic _idController, Function _eliminarVia) {
  return new AlertDialog(
    title: Text(
      _nameController.toString(),
      style: TextStyle(fontFamily: context.resources.fonts.tittle),
    ),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(context.resources.strings.escalarViaScreeDeleteDescription)
      ],
    ),
    actions: <Widget>[
      new ElevatedButton(
        onPressed: () async {
          _eliminarVia(
            context,
            _idController,
          );
        },
        // buttonstyle:(textColor: Theme.of(context).primaryColor),
        child: Text(
          context.resources.strings.escalarViaScreeDeleteDescriptionButton,
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ),
    ],
  );
}

Widget botoneraCargar(bool isConnected, Function _cargarViaTroncho, Vias via,
    BuildContext context) {
  return GestureDetector(
      onTap: () async {
        if (isConnected == true) {
          await _cargarViaTroncho(via.presas);
          ViaData = via;
          indexData = via.sId;
        }
      },
      child: botonCargar(isConnected, context));
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
