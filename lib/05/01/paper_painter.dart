import 'package:flutter/material.dart';

import 'model/paint_model.dart';

class PaperPainter extends CustomPainter {
  final PaintModel model;

  PaperPainter({required this.model}):super(repaint: model);

  Paint _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
      model.lines.forEach((line) => line.paint(canvas,_paint));
  }

  @override
  bool shouldRepaint(covariant PaperPainter oldDelegate) =>
      oldDelegate.model != model;
}
