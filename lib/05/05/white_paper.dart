import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'component/paint_setting_dialog.dart';
import 'model/line.dart';
import 'model/paint_model.dart';
import 'model/point.dart';
import 'paper_painter.dart';

class WhitePaper extends StatefulWidget {
  @override
  _WhitePaperState createState() => _WhitePaperState();
}

class _WhitePaperState extends State<WhitePaper> {
  final PaintModel paintModel = PaintModel();

  Color lineColor = Colors.black;
  double strokeWidth = 1;

  @override
  void dispose() {
    paintModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _showSettingDialog,
        onPanDown: _initLineData,
        onPanUpdate: _collectPoint,
        onLongPressStart: _activeEdit,
        onLongPressUp: _cancelEdit,
        onLongPressMoveUpdate: _moveEdit,
        onPanEnd: _doneALine,
        onPanCancel: _cancel,
        onDoubleTap: _clear,
        child: CustomPaint(
            size: MediaQuery.of(context).size,
            painter: PaperPainter(model: paintModel)));
  }

  void _initLineData(DragDownDetails details) {
    print('_initLineData');
    Line line = Line(color: lineColor, strokeWidth: strokeWidth);
    paintModel.pushLine(line);
    paintModel.pushPoint(Point.fromOffset(details.localPosition));
  }

  void _doneALine(DragEndDetails details) {
    paintModel.doneLine();
  }

  void _collectPoint(DragUpdateDetails details) {
    print('_collectPoint: ${paintModel.lines.length}');

    paintModel.pushPoint(Point.fromOffset(details.localPosition));
  }

  void _clear() {
    paintModel.clear();
  }

  void _cancel() {
    paintModel.removeEmpty();
  }

  void _showSettingDialog() {
    showCupertinoModalPopup(
        context: context,
        builder: (context) => PaintSettingDialog(
              initColor: lineColor,
              initWidth: strokeWidth,
              onLineWidthSelect: _selectWidth,
              onColorSelect: _selectColor,
            ));
  }

  void _selectWidth(double width) {
    strokeWidth = width;
  }

  void _selectColor(Color color) {
    lineColor = color;
  }

  void _activeEdit(LongPressStartDetails details) {
    paintModel.activeEditLine(Point.fromOffset(details.localPosition));
  }

  void _cancelEdit() {
    paintModel.cancelEditLine();
  }

  void _moveEdit(LongPressMoveUpdateDetails details) {
    paintModel.moveEditLine(details.offsetFromOrigin);
  }
}
