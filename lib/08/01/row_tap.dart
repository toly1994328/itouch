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
    };
    return Column(
      children: [
        const Divider(),
        RawGestureDetector(
          gestures: gestures,
          child: Container(
              width: 100.0,
              height: 100.0,
              color: color,
              alignment: Alignment.center,
              child: Text("action:$action",
                style: TextStyle(color: Colors.white),)),
        ),
      ],
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
}
