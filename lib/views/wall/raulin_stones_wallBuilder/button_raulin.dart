import 'package:flutter/material.dart';

class WallButtonRaulin extends StatefulWidget {
  final int index;
  final Function sendMessage;

  const WallButtonRaulin({
    required this.index,
    required this.sendMessage,
  });

  @override
  State<WallButtonRaulin> createState() => _WallButtonRaulinState();
}

class _WallButtonRaulinState extends State<WallButtonRaulin> {
  bool isActivated = false;
  Color color = Colors.transparent;
  _activate() => {
        widget.sendMessage("${widget.index}.65280"),
        setState(
          () => {isActivated = true, color = Colors.red},
        ),
      };
  void _activateInit() => {
        widget.sendMessage("${widget.index}.16777215"),
        setState(() => {
              isActivated = true,
              color = Colors.white,
            })
      };
  _unactivate() => {
        widget.sendMessage("${widget.index}.0"),
        setState(() => {
              isActivated = false,
              color = Colors.transparent,
            })
      };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: color,
          )),
      child: GestureDetector(
        onTap: () => {_activate()},
        onDoubleTap: () => _unactivate(),
        onLongPress: () => _activateInit(),

        //child: Text("${widget.index}")
      ),
    );
  }
}

// checkear si el index contains en la lista de strings ->  if (widget.presas.contains("$index"+",") )
