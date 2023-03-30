import 'package:Nimbus/template/AppContextExtension.dart';
import 'package:flutter/material.dart';

Widget texto(String text, BuildContext context) {
  return Text(text,
      style: TextStyle(fontFamily: context.resources.fonts.tittle));
}
