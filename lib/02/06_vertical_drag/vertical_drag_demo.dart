
import 'package:flutter/material.dart';

class VerticalDragDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onVerticalDragDown: _onVerticalDragDown,
        onVerticalDragStart: _onVerticalDragStart,
        onVerticalDragUpdate: _onVerticalDragUpdate,
        onVerticalDragCancel: _onVerticalDragCancel,
        onVerticalDragEnd: _onVerticalDragEnd,
        child: Container(color: Colors.blue, height: 200,width: 200,));
  }

  void _onVerticalDragDown(DragDownDetails details) {
    print('_onVerticalDragDown:'
        'localPosition:${parserOffset(details.localPosition)};'
        'globalPosition:${parserOffset(details.globalPosition)};');
  }

  void _onVerticalDragStart(DragStartDetails details) {
    print('_onVerticalDragStart:'
        'localPosition:${parserOffset(details.localPosition)};'
        'globalPosition:${parserOffset(details.globalPosition)};'
        'sourceTimeStamp:${details.sourceTimeStamp};'
        'kind:${details.kind};');
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    print('_onVerticalDragUpdate:'
        'localPosition:${parserOffset(details.localPosition)};'
        'globalPosition:${parserOffset(details.globalPosition)};'
        'sourceTimeStamp:${details.sourceTimeStamp};'
        'delta:${details.delta};'
        'primaryDelta:${details.primaryDelta};');
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    print('_onVerticalDragEnd:'
        'velocity:${details.velocity};'
        'primaryVelocity:${details.primaryVelocity};');
  }

  void _onVerticalDragCancel() {
    print('-----_onVerticalDragCancel---------');
  }

  String parserOffset(Offset offset) {
    return '(${offset.dx.toStringAsFixed(2)},${offset.dy.toStringAsFixed(2)})';
  }

}

