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
    var gestures = <Type, GestureRecognizerFactory>{
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
          width: 100.0,
          height: 100.0,
          color: color,
          alignment: Alignment.center,
          child: Text("action:$action",
            style: TextStyle(color: Colors.white),)),
    );
  }

  void _doubleTap() {
    print('_doubleTap');

    setState(() {
      action = 'doubleTap';
      color = Colors.yellow;
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
