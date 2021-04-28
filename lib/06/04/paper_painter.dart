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
    canvas.translate(size.width / 2, size.height / 2);
    canvas.transform(model.matrix.storage);
    canvas.translate(-size.width / 2, -size.height / 2);

    model.lines.forEach((line) {
        line.paint(canvas,_paint);
      });
  }

  @override
  bool shouldRepaint(covariant PaperPainter oldDelegate) =>
      oldDelegate.model != model;
}
