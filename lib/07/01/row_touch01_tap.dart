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
      TapGestureRecognizer: GestureRecognizerFactoryWithHandlers<
          TapGestureRecognizer>(
            () => TapGestureRecognizer(),
            (TapGestureRecognizer instance) => instance
            ..onTapDown = _tapDown
            ..onTapUp = _tapUp
            ..onTap = _tap
            ..onTapCancel = _tapCancel,
      ),
      // PanGestureRecognizer: GestureRecognizerFactoryWithHandlers<
      //     PanGestureRecognizer>(
      //       () {
      //     return PanGestureRecognizer();
      //   },
      //       (PanGestureRecognizer instance) {
      //     instance
      //       ..onDown = onPanDown
      //       ..onStart = onPanStart
      //       ..onUpdate = onPanUpdate
      //       ..onEnd = onPanEnd
      //       ..onCancel = onPanCancel;
      //   },
      // ),

      // DoubleTapGestureRecognizer: GestureRecognizerFactoryWithHandlers<DoubleTapGestureRecognizer>(
      //       () {
      //     return DoubleTapGestureRecognizer();
      //   },
      //       (DoubleTapGestureRecognizer instance) {
      //     instance
      //       ..onDoubleTap = _doubleTap
      //       ..onDoubleTapDown = _doubleDown
      //       ..onDoubleTapCancel =_doubleTapCancel;
      //   },
      // ),
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
      color = Colors.green;
    });
  }

  void _tap() {
    print('_tap');
    setState(() {
      action = 'tap';
    });
  }

  void _tapCancel() {
    print('_tapCancel');
    setState(() {
      action = 'cancel';
      color = Colors.red;
    });
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
  }


  void _doubleTapCancel() {
    print('_doubleTapCancel');
  }

  void onPanDown(DragDownDetails details) {
    print('onPanDown');
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
