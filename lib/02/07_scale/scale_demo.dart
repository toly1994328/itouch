import 'package:flutter/material.dart';

class ScaleDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onScaleStart: _onScaleStart,
        onScaleUpdate: _onScaleUpdate,
        onScaleEnd: _onScaleEnd,
        child: Container(color: Colors.blue, height: 200,width: 200,));
  }

  void _onScaleStart(ScaleStartDetails details) {
    print('_onScaleStart:'
        'focalPoint:${parserOffset(details.focalPoint)};'
        'localFocalPoint:${parserOffset(details.localFocalPoint)};'
        'pointerCount:${details.pointerCount};'
    );
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    print('_onScaleUpdate:'
        'focalPoint:${parserOffset(details.focalPoint)};'
        'localFocalPoint:${parserOffset(details.localFocalPoint)};'
        'pointerCount:${details.pointerCount};'
        'scale:${details.scale.toStringAsFixed(2)};'
        'horizontalScale:${details.horizontalScale.toStringAsFixed(2)};'
        'verticalScale:${details.verticalScale.toStringAsFixed(2)};'
        'rotation:${details.rotation.toStringAsFixed(2)};');
  }

  void _onScaleEnd(ScaleEndDetails details) {
    print('_onScaleEnd:'
        'velocity:${details.velocity};'
        'pointerCount:${details.pointerCount};');
  }

  String parserOffset(Offset offset) {
    return '(${offset.dx.toStringAsFixed(2)},${offset.dy.toStringAsFixed(2)})';
  }
}
