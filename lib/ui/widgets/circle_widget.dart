import 'package:flutter/material.dart';
import 'package:notes_app/core/src/constants.dart';

///
class CircleWidget extends StatelessWidget {
  ///
  final int color;

  ///
  final int circleTap;

  ///
  const CircleWidget({Key? key, required this.color, required this.circleTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: colorPallete[color],
          shape: BoxShape.circle,
          border: Border.all(width: 2.0, color: Colors.black38),
        ),
        child: color == circleTap ? const Icon(Icons.done) : null,
      ),
    );
  }
}
