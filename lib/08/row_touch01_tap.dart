import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'three_strikes.dart';

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
      ThreeTapGestureRecognizer:
          GestureRecognizerFactoryWithHandlers<ThreeTapGestureRecognizer>(
        () {
          return ThreeTapGestureRecognizer();
        },
        (ThreeTapGestureRecognizer instance) {
          instance
            ..onThreeTap = _onThreeTap
            ..onThreeTapDown = _onThreeTapDown
            ..onThreeTapCancel = _onThreeTapCancel;
        },
      ),
      // DoubleTapGestureRecognizer:
      //     GestureRecognizerFactoryWithHandlers<DoubleTapGestureRecognizer>(() {
      //   return DoubleTapGestureRecognizer();
      // }, (DoubleTapGestureRecognizer instance) {
      //   instance
      //     ..onDoubleTap = _doubleTap
      //     ..onDoubleTapDown = _doubleDown
      //     ..onDoubleTapCancel = _doubleTapCancel;
      // }),
      TapGestureRecognizer:
      GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(() {
        return TapGestureRecognizer();
      }, (TapGestureRecognizer instance) {
        instance
          ..onTap = _tap;
      })
    };
    return RawGestureDetector(
      gestures: gestures,
      child: Container(
          width: 100.0,
          height: 100.0,
          color: color,
          alignment: Alignment.center,
          child: Text(
            "action:$action",
            style: TextStyle(color: Colors.white),
          )),
    );
  }

  void _tapDown(TapDownDetails details) {
    print('_tapDown');
    setState(() {
      action = 'down';
      color = Colors.blue;
    });
  }

  void _tapUp(TapUpDetails details) {
    print('_tapUp');

    setState(() {
      action = 'up';
      color = Colors.purple;
    });
  }

  void _tap() {
    print('_tap');
    setState(() {
      action = 'tap';
      color = Colors.purple;
    });
  }

  void _tapCancel() {
    print('_tapCancel');
    setState(() {
      action = 'cancel';
      color = Colors.orange;
    });
  }

  void _onThreeTap() {
    print('_onThreeTap');
    setState(() {
      action = '_onThreeTap';
      color = Colors.green;
    });
  }

  void _onThreeTapDown(TapDownDetails details) {
    print('_onThreeTapDown');
  }

  void _onThreeTapCancel() {
    print('_onThreeTapCancel');
  }

  void onPanDown(DragDownDetails details) {
    print('onPanDown');
  }

  void _doubleTap() {
    print('_doubleTap');

    setState(() {
      action = 'doubleTap';
      color = Colors.red;
    });
  }

  void _doubleDown(TapDownDetails details) {
    print('_doubleDown');
  }

  void _doubleTapCancel() {
    print('_doubleTapCancel');
  }

  void onPanStart(DragStartDetails details) {
    print('onPanStart');
  }

  void onPanUpdate(DragUpdateDetails details) {
    print('onPanUpdate');
  }

  void onPanEnd(DragEndDetails details) {
    print('onPanEnd');
  }

  void onPanCancel() {
    print('onPanCancel');
  }
}
