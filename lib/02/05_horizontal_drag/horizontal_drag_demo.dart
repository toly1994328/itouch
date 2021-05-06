
import 'package:flutter/material.dart';

class HorizontalDragDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onHorizontalDragDown: _onHorizontalDragDown,
        onHorizontalDragStart: _onHorizontalDragStart,
        onHorizontalDragUpdate: _onHorizontalDragUpdate,
        onHorizontalDragCancel: _onHorizontalDragCancel,
        onHorizontalDragEnd: _onHorizontalDragEnd,
        child: Container(color: Colors.blue, height: 200,width: 200,));
  }

  void _onHorizontalDragDown(DragDownDetails details) {
    print('_onHorizontalDragDown:'
        'localPosition:${parserOffset(details.localPosition)};'
        'globalPosition:${parserOffset(details.globalPosition)};');
  }

  void _onHorizontalDragStart(DragStartDetails details) {
    print('_onHorizontalDragStart:'
        'localPosition:${parserOffset(details.localPosition)};'
        'globalPosition:${parserOffset(details.globalPosition)};'
        'sourceTimeStamp:${details.sourceTimeStamp};'
        'kind:${details.kind};');
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    print('_onHorizontalDragUpdate:'
        'localPosition:${parserOffset(details.localPosition)};'
        'globalPosition:${parserOffset(details.globalPosition)};'
        'sourceTimeStamp:${details.sourceTimeStamp};'
        'delta:${details.delta};'
        'primaryDelta:${details.primaryDelta};');
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    print('_onHorizontalDragEnd:'
        'velocity:${details.velocity};'
        'primaryVelocity:${details.primaryVelocity};');
  }

  void _onHorizontalDragCancel() {
    print('-----_onHorizontalDragCancel---------');
  }

  String parserOffset(Offset offset) {
    return '(${offset.dx.toStringAsFixed(2)},${offset.dy.toStringAsFixed(2)})';
  }

}
