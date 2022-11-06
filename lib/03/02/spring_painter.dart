import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const double _kSpringWidth = 30;

class SpringPainter extends CustomPainter {
  final int count;
  final ValueListenable<double> height;

  SpringPainter({this.count = 20,required this.height}):super(repaint: height);

  Paint _paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;


  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2 + _kSpringWidth / 2, size.height);
    Path springPath = Path();
    springPath.relativeLineTo(-_kSpringWidth, 0);

    double space = height.value/(count+1);

    for (int i = 1; i < count; i++) {
      if (i % 2 == 1) {
        springPath.relativeLineTo(_kSpringWidth, -space);
      } else {
        springPath.relativeLineTo(-_kSpringWidth, -space);
      }
    }
    springPath.relativeLineTo(count.isOdd?_kSpringWidth:-_kSpringWidth, 0);

    canvas.drawPath(springPath, _paint);
  }

  @override
  bool shouldRepaint(covariant SpringPainter oldDelegate) =>
      oldDelegate.count != count || oldDelegate.height != height;
}
