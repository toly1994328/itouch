import 'package:flutter/material.dart';

import 'model/paint_model.dart';

class PaperPainter extends CustomPainter {
  final PaintModel model;

  PaperPainter({this.model}):super(repaint: model);

  Paint _paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  @override
  void paint(Canvas canvas, Size size) {

    final Matrix4 result = Matrix4.identity();
    result.translate(size.width / 2, size.height / 2);
    result.multiply(model.matrix);
    result.translate(-size.width / 2, -size.height / 2);

    canvas.transform(result.storage);

    model.lines.forEach((line) {
        line.paint(canvas,size,_paint);
      });
  }

  // Matrix4  _effectiveTransform(Offset origin) {
  //
  //   if (origin == null)
  //     return model.matrix;
  //   final Matrix4 result = Matrix4.identity();
  //   if (origin != null)
  //     result.translate(origin.dx, origin.dy);
  //   result.multiply(model.matrix);
  //   if (origin != null)
  //     result.translate(-origin.dx, -origin.dy);
  //   return result;
  // }


  @override
  bool shouldRepaint(covariant PaperPainter oldDelegate) =>
      oldDelegate.model != model;
}
