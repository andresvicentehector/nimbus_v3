import 'package:flutter/material.dart';

class WallButtonDictado extends StatefulWidget {
  final int index;
  final Function sendMessage;
  final double height;

  const WallButtonDictado(
      {required this.index, required this.sendMessage, required this.height});

  @override
  State<WallButtonDictado> createState() => _WallButtonDictadoState();
}

class _WallButtonDictadoState extends State<WallButtonDictado> {
  bool isActivated = false;

  _activate() => {
        widget.sendMessage("${widget.index}.255"),
        setState(() => isActivated = true),
      };
  _unactivate() => {
        widget.sendMessage("${widget.index}.0"),
        setState(
          () => isActivated = false,
        )
      };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isActivated ? Colors.blue : Colors.transparent,
            )),
        child: GestureDetector(
          onTap: () => {
            _activate(),
          },
          onDoubleTap: () => _unactivate(),
        ),
      ),
    );
  }
}

// checkear si el index contains en la lista de strings ->  if (widget.presas.contains("$index"+",") )
