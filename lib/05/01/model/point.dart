import 'package:flutter/cupertino.dart';

class Point {
  final double x;
  final double y;

  const Point({this.x=0, this.y=0});

  factory Point.fromOffset(Offset offset) {
    return Point(
      x: offset.dx,
      y: offset.dy,
    );
  }

  Offset toOffset()=> Offset(x,y);
}
