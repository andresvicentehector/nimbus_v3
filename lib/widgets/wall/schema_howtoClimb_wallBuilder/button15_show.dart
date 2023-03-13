import 'package:flutter/material.dart';

class Wall15ShowButton extends StatefulWidget {
  final int index;
  final List<String> presas;
  final Color c2;
  final int numero;

  const Wall15ShowButton(
      {required this.index,
      required this.c2,
      required this.presas,
      required this.numero});

  @override
  State<Wall15ShowButton> createState() => _Wall15ShowButtonState();
}

class _Wall15ShowButtonState extends State<Wall15ShowButton> {
  bool isActivated = false;
  late bool marcar = false;
  late Color c1;
  late AnimationController controller;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 39,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.transparent)),
        child: Stack(children: [
          GestureDetector(
            child: Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: widget.c2))),
                Center(
                    child: widget.numero == 10000
                        ? SizedBox.shrink()
                        : Text("${widget.numero}",
                            style: TextStyle(
                              color: widget.c2,
                            ))),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
