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
      MultiTapGestureRecognizer:
          GestureRecognizerFactoryWithHandlers<MultiTapGestureRecognizer>(
        () => MultiTapGestureRecognizer(),
        (MultiTapGestureRecognizer instance) => instance
          ..onTap = _onMultiTap
          ..onTapUp = _onMultiTapUp
          ..onTapDown = _onMultiTapDown
          ..onTapCancel = _onMultiTapCancel
          ..onLongTapDown = _onLongMultiTapDown,
      ),
      // TapGestureRecognizer: GestureRecognizerFactoryWithHandlers<
      //     TapGestureRecognizer>(
      //       () {
      //     return TapGestureRecognizer();
      //   },
      //       (TapGestureRecognizer instance) {
      //     instance
      //       ..onTapDown = _tapDown
      //       ..onTapUp = _tapUp
      //       ..onTap = _tap
      //       ..onTapCancel = _tapCancel;
      //   },
      // ),
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
            "多触点测试",
            style: TextStyle(color: Colors.white),
          )),
    );
  }

  void _onMultiTap(int pointer) {
    print('_onTap-----[$pointer]--');
  }

  void _onMultiTapUp(int pointer, TapUpDetails details) {
    print('_onTapUp-----[$pointer]---${details}----');
  }

  void _onMultiTapDown(int pointer, TapDownDetails details) {
    print('_onTapDown-----[$pointer]---${details}----');
  }

  void _onMultiTapCancel(int pointer) {
    print('_onTapCancel-----[$pointer]------');
  }

  void _onLongMultiTapDown(int pointer, TapDownDetails details) {
    print('_onLongTapDown-----[$pointer]---${details}----');
  }


  void _tapDown(TapDownDetails details) {
    print('_tapDown');
  }

  void _tapUp(TapUpDetails details) {
    print('_tapUp');
  }

  void _tap() {
    print('_tap');
  }

  void _tapCancel() {
    print('_tapCancel');

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
