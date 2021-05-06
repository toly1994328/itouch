import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(Directionality(
      textDirection: TextDirection.ltr,
      child: CustomPaint(
        painter: Painter(),
      )));
}

class Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()
      ..color = Colors.white);



    canvas.translate(size.width / 2, size.height / 2);

    canvas.drawCircle(Offset.zero, 5, Paint());

    Paint paint = Paint()
      ..style = PaintingStyle.stroke..strokeWidth=1;

    Path path = Path();


    // path..relativeMoveTo(-paint.strokeWidth/2,boxHeight/2+paint.strokeWidth/2)
    // path..relativeMoveTo(0,boxHeight/2)
    //   ..relativeLineTo(-(boxWidth/2-radius), 0)
    //   ..relativeArcToPoint(Offset(-radius,-radius),radius: Radius.circular(radius))
    //   ..relativeLineTo( 0,-(boxHeight-radius*2))
    //   ..relativeArcToPoint(Offset(radius,-radius),radius: Radius.circular(radius))
    //   ..relativeLineTo( boxWidth-radius*2,0)
    //   ..relativeArcToPoint(Offset(radius,radius),radius: Radius.circular(radius))
    //   ..relativeLineTo( 0,boxHeight-radius*2)
    //   ..relativeArcToPoint(Offset(-radius,radius),radius: Radius.circular(radius))..close();


    // path.addRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: Offset.zero, width: boxWidth,height: boxHeight), Radius.circular(10)));

    canvas.drawPath(path, paint..color=Colors.grey);


    // path.computeMetrics();
    // canvas.drawPath(path, paint);

    final PathMetrics metrics = path.computeMetrics();

    for (final PathMetric metric in metrics) {
      _drawMetric(canvas, paint, metric);
    }


    print(size);
  }
  final double boxWidth = 100;
  final double boxHeight = 80;
  final double radius = 10;


  void _drawMetric(Canvas canvas, Paint paint, PathMetric metric) {
    final double progress=0.0;
    canvas.drawPath(
      metric.extractPath(0, metric.length * progress),
      paint..color = Colors.blue,
    );
  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
