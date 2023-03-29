import 'package:flutter/material.dart';
import 'BaseColors.dart';

class AppColors implements BaseColors {
  Map<int, Color> _primary = {
    50: Color.fromRGBO(47, 0, 233, 0.1),
    100: Color.fromRGBO(47, 0, 233, 0.2),
    200: Color.fromRGBO(47, 0, 233, 0.3),
    300: Color.fromRGBO(47, 0, 233, 0.4),
    400: Color.fromRGBO(47, 0, 233, 0.5),
    500: Color.fromRGBO(47, 0, 233, 0.6),
    600: Color.fromRGBO(47, 0, 233, 0.7),
    700: Color.fromRGBO(47, 0, 233, 0.8),
    800: Color.fromRGBO(47, 0, 233, 0.9),
    900: Color.fromRGBO(47, 0, 233, 1.0),
  };

  @override
  Color get colorAccent => Color.fromARGB(255, 213, 252, 32);

  @override
  MaterialColor get colorPrimary => MaterialColor(0xFF2F00E9, _primary);

  @override
  Color get colorPrimaryText => Color.fromARGB(255, 255, 255, 255);

  @override
  Color get colorSecondaryText => Color.fromARGB(255, 0, 0, 0);

  @override
  Color get colorWhite => Color(0xffffffff);

  @override
  Color get colorBlack => Color(0xff000000);
  @override
  Color get colorContainer => Color.fromARGB(255, 0, 0, 0);

  @override
  Color get castChipColor => Colors.deepOrangeAccent;

  @override
  Color get catChipColor => Colors.indigoAccent;
}
