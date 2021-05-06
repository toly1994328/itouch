
import 'package:flutter/material.dart';

class PanDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Container(
        height: 200,
        color: Colors.grey.withAlpha(33),
        child: ListView(
          children: [
            GestureDetector(
                onPanStart: _onPanStart,
                onPanDown: _onPanDown,
                onPanEnd: _onPanEnd,
                onPanCancel: _onPanCancel,
                onPanUpdate: _onPanUpdate,
                child: Container(color: Colors.blue, height: 80)),
            Container(color: Colors.red, height: 80),
            Container(color: Colors.yellow, height: 80),
            Container(color: Colors.green, height: 80),
          ],
        ),
      ),
    );
  }

  void _onPanDown(DragDownDetails details) {
    print('_onPanDown:'
        'localPosition:${parserOffset(details.localPosition)};'
        'globalPosition:${parserOffset(details.globalPosition)};');
  }

  void _onPanStart(DragStartDetails details) {
    print('_onPanStart:'
        'localPosition:${parserOffset(details.localPosition)};'
        'globalPosition:${parserOffset(details.globalPosition)};'
        'sourceTimeStamp:${details.sourceTimeStamp};'
        'kind:${details.kind};');
  }

  void _onPanUpdate(DragUpdateDetails details) {
    print('_onPanUpdate:'
        'localPosition:${parserOffset(details.localPosition)};'
        'globalPosition:${parserOffset(details.globalPosition)};'
        'sourceTimeStamp:${details.sourceTimeStamp};'
        'delta:${details.delta};'
        'primaryDelta:${details.primaryDelta};');
  }

  void _onPanEnd(DragEndDetails details) {
    print('_onPanEnd:'
        'velocity:${details.velocity};'
        'primaryVelocity:${details.primaryVelocity};');
  }

  void _onPanCancel() {
    print('-----_onPanCancel---------');
  }

  String parserOffset(Offset offset) {
    return '(${offset.dx.toStringAsFixed(2)},${offset.dy.toStringAsFixed(2)})';
  }
}
