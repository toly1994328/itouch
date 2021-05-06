
import 'package:flutter/material.dart';

class DoubleTapDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onDoubleTap: _onDoubleTap,
        onDoubleTapDown: _onDoubleTapDown,
        onDoubleTapCancel: _onDoubleTapCancel,
        child: Container(color: Colors.blue, height: 100, width: 100,));
  }

  void _onDoubleTap() {
    print('-----_onDoubleTap---------');
  }

  void _onDoubleTapDown(TapDownDetails details) {
    print('-----_onDoubleTapDown-localPosition:--${details.localPosition}------');
    print('-----_onDoubleTapDown-globalPosition:--${details.globalPosition}------');
    print('-----_onDoubleTapDown-kind:--${details.kind}------');
  }

  void _onDoubleTapCancel() {
    print('-----_onDoubleTapCancel---------');
  }
}
