import 'package:flutter/material.dart';

Widget texto(String text, BuildContext context) {
  return Text(text,
      style: TextStyle(
          color: Theme.of(context).colorScheme.tertiary,
          fontFamily: 'ClashDisplay'));
}
