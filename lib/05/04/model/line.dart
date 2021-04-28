import 'dart:ui';

import 'package:flutter/material.dart';

import 'point.dart';

enum PaintState { doing, done, hide }

class Line {
  List<Point> points = [];
  PaintState state;
  double strokeWidth;
  Color color;

  Path _linePath = Path();

  Line(
      {this.color = Colors.black,
      this.strokeWidth = 1,
      this.state = PaintState.doing});

  void paint(Canvas canvas, Paint paint) {
    paint
      ..style = PaintingStyle.stroke
      ..color = color
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    if (state == PaintState.doing) {
      _linePath = formPath();
    }

    canvas.drawPath(_linePath, paint);

    Path p1 =_linePath.shift(Offset(paint.strokeWidth/2, paint.strokeWidth/2));
    Path p2 =_linePath.shift(Offset(-paint.strokeWidth/2, -paint.strokeWidth/2));
    Paint paint1= Paint()..strokeWidth=1 ..style = PaintingStyle.stroke;
    canvas.drawPath(p1, paint1);
    canvas.drawPath(p2, paint1);
  }

  Path formPath() {
    Path path = Path();
    for (int i = 0; i < points.length - 1; i++) {
      Point current = points[i];
      Point next = points[i + 1];
      if (i == 0) {
        path.moveTo(current.x, current.y);
        path.lineTo(next.x, next.y);
      } else if (i <= points.length - 2) {
        double xc = (points[i].x + points[i + 1].x) / 2;
        double yc = (points[i].y + points[i + 1].y) / 2;
        Point p2 = points[i];
        path.quadraticBezierTo(p2.x, p2.y, xc, yc);
      } else {
        path.moveTo(current.x, current.y);
        path.lineTo(next.x, next.y);
      }
    }
    return path;
  }

  @override
  String toString() {
    return 'Line{points: $points, state: $state, strokeWidth: $strokeWidth, color: $color}';
  }
}
