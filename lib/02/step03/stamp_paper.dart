import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
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
    double width = MediaQuery.of(context).size.shortestSide * 0.8;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onDoubleTap: _clear,
      onTapCancel: _removeLast,
      child: CustomPaint(
        foregroundPainter: StampPainter(stamps: stamps),
        painter: BackGroundPainter(),
        size: Size(width, width),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    stamps.push(Stamp(center: details.localPosition, color: Colors.grey));
  }

  void _onTapUp(TapUpDetails details) {
    stamps.activeLast(
        color: stamps.stamps.length%2==0?Colors.red:Colors.blue);
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

class BackGroundPainter extends CustomPainter {

  final Paint _pathPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  int count = 3;

  List<Color> colors = [
    Color(0xFFF60C0C),
    Color(0xFFF3B913),
    Color(0xFFE7F716),
    Color(0xFF3DF30B),
    Color(0xFF0DF6EF),
    Color(0xFF0829FB),
    Color(0xFFB709F4),
  ];

  List<double> pos = [1.0 / 7, 2.0 / 7, 3.0 / 7, 4.0 / 7, 5.0 / 7, 6.0 / 7, 1.0];

  @override
  void paint(Canvas canvas, Size size) {
    Rect zone = Offset.zero & size;
    canvas.clipRect(zone);

    _pathPaint.shader =
        ui.Gradient.sweep(Offset(size.width/2, size.height/2), colors, pos, TileMode.mirror, pi / 2, pi);

    canvas.save();
    for (int i = 0; i < count - 1; i++) {
      canvas.translate(0, size.height / count);
      canvas.drawLine(Offset.zero, Offset(size.width, 0), _pathPaint);
    }
    canvas.restore();

    canvas.save();
    for (int i = 0; i < count - 1; i++) {
      canvas.translate(size.width / count, 0);
      canvas.drawLine(Offset.zero, Offset(0, size.height), _pathPaint);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
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
    Rect zone = Offset.zero & size;
    canvas.clipRect(zone);
    stamps.stamps.forEach((element) {
      canvas.drawCircle(
          element.center, element.radius, _paint..color = element.color);
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

  Stamp({this.color = Colors.blue, this.center, this.radius = 20});

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

  void activeLast({Color color = Colors.blue}) {
    stamps.last.color = color;
    notifyListeners();
  }

  void clear() {
    stamps.clear();
    notifyListeners();
  }
}
