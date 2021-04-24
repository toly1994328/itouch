import 'package:flutter/material.dart';
import 'spring_painter.dart';

class SpringWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Container(
        width: 200,
        height: 200,
        color: Colors.grey.withAlpha(11),
        child: CustomPaint(
          painter: SpringPainter(
            height: 120
              // space: 2
          )
        ),
      );
  }
}
