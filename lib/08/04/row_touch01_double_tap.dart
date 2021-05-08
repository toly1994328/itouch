import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RawGestureDetectorDemo extends StatefulWidget {
  @override
  _RawGestureDetectorDemoState createState() => _RawGestureDetectorDemoState();
}

class _RawGestureDetectorDemoState extends State<RawGestureDetectorDemo> {
  String action = '';
  Color color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    Map<Type, GestureRecognizerFactory> gestures = {
      DoubleTapGestureRecognizer:
          GestureRecognizerFactoryWithHandlers<DoubleTapGestureRecognizer>(
        () => DoubleTapGestureRecognizer(),
        (DoubleTapGestureRecognizer instance) => instance
          ..onDoubleTap = _doubleTap
          ..onDoubleTapDown = _doubleDown
          ..onDoubleTapCancel = _doubleTapCancel,
      ),
    };

    return RawGestureDetector(
      gestures: gestures,
      child: Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: Text(
            "双击测试",
            style: TextStyle(color: Colors.white),
          )),
    );
  }

  void _doubleTap() {
    print('_doubleTap');
    setState(() {
      action = '_doubleTap';
      color = Colors.green;
    });
  }

  void _doubleDown(TapDownDetails details) {
    print('_doubleDown');
    setState(() {
      action = '_doubleDown';
      color = Colors.orange;
    });
  }

  void _doubleTapCancel() {
    print('_doubleTapCancel');
    setState(() {
      action = '_doubleTapCancel';
      color = Colors.red;
    });
  }
}
