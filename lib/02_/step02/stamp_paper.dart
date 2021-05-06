import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StampPaper extends StatefulWidget {
  @override
  _StampPaperState createState() => _StampPaperState();
}

class _StampPaperState extends State<StampPaper> {
  final StampData stamps = StampData();
  List<Color> colors = [
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.indigo
  ];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onDoubleTap: _clear,
      onTapCancel: _removeLast,
      child: CustomPaint(
        painter: StampPainter(stamps: stamps),
        size: MediaQuery.of(context).size,
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    stamps.push(Stamp(center: details.localPosition, color: Colors.grey));
  }

  void _onTapUp(TapUpDetails details) {
    stamps.activeLast(color: colors[(stamps.stamps.length-1)%colors.length]);
  }

  void _clear() {
    stamps.clear();
  }

  void _removeLast() {
    stamps.removeLast();
  }

  @override
  void dispose() {
    stamps.dispose();
    super.dispose();
  }
}

class StampPainter extends CustomPainter {
  final StampData stamps;
  final Paint _paint = Paint();
  final Paint _pathPaint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  StampPainter({this.stamps}) : super(repaint: stamps);

  @override
  void paint(Canvas canvas, Size size) {
    stamps.stamps.forEach((element) {
      canvas.drawCircle(element.center, element.radius, _paint..color = element.color);
      canvas.drawPath(element.path, _pathPaint..color = Colors.white);
      canvas.drawCircle(element.center, element.radius + 3,
          _pathPaint..color = element.color);
    });
  }

  @override
  bool shouldRepaint(covariant StampPainter oldDelegate) {
    return this.stamps != oldDelegate.stamps;
  }
}

class Stamp {
  Color color;
  Offset center;
  double radius;

  Stamp({this.color = Colors.blue, this.center, this.radius =20});

  Path _path;

  Path get path {
    if (_path == null) {
      _path = Path();
      double r = radius;
      double rad = 30 / 180 * pi;

      _path..moveTo(center.dx, center.dy);
      _path.relativeMoveTo(r * cos(rad), -r * sin(rad));
      _path.relativeLineTo(-2 * r * cos(rad), 0);
      _path.relativeLineTo(r * cos(rad), r + r * sin(rad));
      _path.relativeLineTo(r * cos(rad), -(r + r * sin(rad)));

      _path..moveTo(center.dx, center.dy);
      _path.relativeMoveTo(0, -r);
      _path.relativeLineTo(-r * cos(rad), r + r * sin(rad));
      _path.relativeLineTo(2 * r * cos(rad), 0);
      _path.relativeLineTo(-r * cos(rad), -(r + r * sin(rad)));

      return _path;
    } else {
      return _path;
    }
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

  void activeLast({Color color=Colors.blue}) {
    stamps.last.color = color;
    notifyListeners();
  }

  void clear() {
    stamps.clear();
    notifyListeners();
  }
}
