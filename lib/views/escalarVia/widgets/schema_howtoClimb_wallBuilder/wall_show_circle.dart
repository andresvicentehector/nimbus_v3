import 'package:flutter/material.dart';

// ignore: camel_case_types
class WallShowCircle extends StatelessWidget {
  final Color c2;
  final int numero;

  const WallShowCircle({required this.c2, required this.numero});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GestureDetector(
        child: Stack(
          children: [
            Container(
                decoration: BoxDecoration(
                    color: numero == 10000
                        ? Colors.transparent
                        : Color.fromARGB(193, 126, 124, 124),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: c2))),
            Center(
                child: numero == 10000
                    ? SizedBox.shrink()
                    : Text("$numero",
                        style: TextStyle(
                          shadows: [
                            Shadow(
                              blurRadius: 1,
                              color: Color.fromARGB(255, 0, 0, 0),
                              offset: Offset(0.4, 0.5),
                            ),
                          ],
                          color: c2,
                        ))),
          ],
        ),
      )
    ]);
  }
}
