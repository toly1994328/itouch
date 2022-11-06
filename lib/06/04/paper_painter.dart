import 'package:flutter/material.dart';

import 'model/paint_model.dart';

class PaperPainter extends CustomPainter {
  final PaintModel model;

  PaperPainter({required this.model}):super(repaint: model);

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
        line.paint(canvas,size,_paint,model.matrix);
      });
  }

  @override
  bool shouldRepaint(covariant PaperPainter oldDelegate) =>
      oldDelegate.model != model;
}
