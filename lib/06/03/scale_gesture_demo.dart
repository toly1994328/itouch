import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ScaleGestureDemo extends StatefulWidget {
  @override
  _ScaleGestureDemoState createState() => _ScaleGestureDemoState();
}

class _ScaleGestureDemoState extends State<ScaleGestureDemo> {
  final ValueNotifier<Matrix4> matrix = ValueNotifier<Matrix4>(Matrix4.identity());
  Matrix4 recodeMatrix = Matrix4.identity();
  Offset _offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300 * 0.75,
      width: 300,
      color: Colors.cyanAccent.withOpacity(0.1),
      child: GestureDetector(
        onTapDown: _onTapDown,
        onScaleUpdate: _onScaleUpdate,
        onScaleEnd: _onScaleEnd,
        onScaleStart: _onScaleStart,
        child: CustomPaint(
          painter: GesturePainter(matrix: matrix),
        ),
      ),
    );
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    if (details.pointerCount == 1) {
      matrix.value = Matrix4.translationValues(
          (details.focalPoint.dx-_offset.dx),
          (details.focalPoint.dy-_offset.dy),
          1)
          .multiplied(recodeMatrix);
    } else {
      if ((details.rotation * 180 / pi).abs() > 15) {
        matrix.value = recodeMatrix.multiplied(Matrix4.rotationZ(details.rotation));
      } else {
        if (details.scale == 1.0) return;
        matrix.value = recodeMatrix.multiplied(
            Matrix4.diagonal3Values(details.scale, details.scale, 1));
      }
    }
  }

  void _onScaleEnd(ScaleEndDetails details) {
    recodeMatrix = matrix.value;
  }

  void _onScaleStart(ScaleStartDetails details) {
    if (details.pointerCount == 1) {
      _offset = details.focalPoint;
    }
  }

  void _onTapDown(TapDownDetails details) {
    print(details.localPosition);
  }
}

class GesturePainter extends CustomPainter {
  Paint girdPaint = Paint()..color = Colors.green..style = PaintingStyle.stroke;
  Path girdPath = Path();
  final ValueListenable<Matrix4> matrix;

  GesturePainter({this.matrix}) : super(repaint: matrix);

  @override
  void paint(Canvas canvas, Size size) {
    Rect zone = Offset.zero & size;
    canvas.clipRect(zone);
    canvas.translate(size.width / 2, size.height / 2);
    canvas.transform(matrix.value.storage);
    drawSomething(canvas, size);
  }

  void drawSomething(Canvas canvas, Size size) {
    canvas.drawCircle(Offset.zero, 10, Paint());
    girdPath.moveTo(-size.width / 2, 0);
    girdPath.relativeLineTo(size.width, 0);
    girdPath.moveTo(0, -size.height / 2);
    girdPath.relativeLineTo(0, size.height);
    canvas.drawPath(girdPath, girdPaint);
    canvas.drawCircle(Offset.zero.translate(4, 4), 1, Paint()..color = Colors.white);
    canvas.drawCircle(Offset.zero.translate(-4, -4), 1, Paint()..color = Colors.white);
    canvas.drawCircle(Offset.zero.translate(4, -4), 1, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant GesturePainter oldDelegate) => false;
}
