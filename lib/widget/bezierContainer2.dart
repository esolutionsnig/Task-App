import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tasks/shared/color.dart';
import 'package:tasks/widget/customClipper.dart';

class BezierContainer2 extends StatelessWidget {
  const BezierContainer2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Transform.rotate(
        angle: -pi / -5.5, 
        child: ClipPath(
        clipper: ClipPainter(),
        child: Container(
          height: MediaQuery.of(context).size.height *.3,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [cLiteRed, cDarkRed]
              )
            ),
        ),
      ),
      )
    );
  }
}