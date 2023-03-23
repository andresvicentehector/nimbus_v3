import 'package:flutter/material.dart';

import '../../../../template/T8Colors.dart';

Widget textoCabecera(String text, BuildContext context) {
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
