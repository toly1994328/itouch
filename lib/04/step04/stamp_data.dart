import 'dart:math';

import 'package:flutter/material.dart';

class Stamp {
  Color color;
  Offset center;
  double radius;

  Stamp({this.color = Colors.blue, this.center=Offset.zero, this.radius = 20});

  Path? _path;

  Path get path {
    if (_path == null) {
      _path = Path();
      double r = radius;
      double rad = 30 / 180 * pi;

      _path!..moveTo(center.dx, center.dy);
      _path!.relativeMoveTo(r * cos(rad), -r * sin(rad));
      _path!.relativeLineTo(-2 * r * cos(rad), 0);
      _path!.relativeLineTo(r * cos(rad), r + r * sin(rad));
      _path!.relativeLineTo(r * cos(rad), -(r + r * sin(rad)));

      _path!..moveTo(center.dx, center.dy);
      _path!.relativeMoveTo(0, -r);
      _path!.relativeLineTo(-r * cos(rad), r + r * sin(rad));
      _path!.relativeLineTo(2 * r * cos(rad), 0);
      _path!.relativeLineTo(-r * cos(rad), -(r + r * sin(rad)));

      return _path!;
    } else {
      return _path!;
    }
  }

  set path(Path path) {
    _path = path;
  }

  void rePath() {
    _path = null;
    _path = path;
  }
}

class StampData extends ChangeNotifier {
  final List<Stamp> stamps = [];

  void push(Stamp stamp) {
    stamps.add(stamp);
    notifyListeners();
  }

  void removeLast() {
    stamps.removeLast();
    notifyListeners();
  }

  void activeLast({Color color = Colors.blue}) {
    stamps.last.color = color;
    notifyListeners();
  }

  void clear() {
    stamps.clear();
    notifyListeners();
  }

  void animateAt(int index, double radius) {
    stamps[index].radius = radius;
    stamps[index].rePath();
    notifyListeners();
  }
}
