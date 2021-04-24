import 'package:flutter/cupertino.dart';

class Point {
  final double x;
  final double y;

  const Point({this.x, this.y});

  factory Point.fromOffset(Offset offset) {
    return Point(
      x: offset.dx,
      y: offset.dy,
    );
  }

  Offset toOffset()=> Offset(x,y);
}
