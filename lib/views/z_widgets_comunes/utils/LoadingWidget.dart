import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      height: 80,
      child: Center(
          child: Stack(
        children: [
          Roulette(
            child: SizedBox(
              height: 80,
              child: Image.asset("images/icon/logo.png"),
            ),
          ),
        ],
      )),
    ));
  }
}
