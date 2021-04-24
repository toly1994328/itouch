import 'dart:ui';

import 'package:flutter/material.dart';

import 'point.dart';

enum PaintState { doing, done, hide }

class Line {
  List<Point> points = [];
  PaintState state;
  double strokeWidth;
  Color color;

  Line(
      {this.color = Colors.black,
      this.strokeWidth = 1,
      this.state = PaintState.doing});

  void paint(Canvas canvas, Paint paint) {
    paint
      ..style = PaintingStyle.stroke
      ..color = state==PaintState.doing?Colors.blue:color
      ..strokeWidth = strokeWidth;
    canvas.drawPoints(PointMode.polygon, points.map<Offset>((e) => e.toOffset()).toList(), paint);
  }

  @override
  String toString() {
    return 'Line{points: $points, state: $state, strokeWidth: $strokeWidth, color: $color}';
  }
}
