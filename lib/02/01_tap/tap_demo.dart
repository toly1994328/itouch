
import 'package:flutter/material.dart';

class TapDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _onTap,
        onTapDown: _onTapDown,
        onTapCancel: _onTapCancel,
        onTapUp: _onTapUp,
        child: Container(color: Colors.blue, height: 100, width: 100,));
  }

  void _onTap() {
    print('-----_onTap---------');
  }

  void _onTapDown(TapDownDetails details) {
    print('-----_onTapDown-localPosition:--${details.localPosition}------');
    print('-----_onTapDown-globalPosition:--${details.globalPosition}------');
    print('-----_onTapDown-kind:--${details.kind}------');
  }

  void _onTapCancel() {
    print('-----_onTapCancel---------');
  }

  void _onTapUp(TapUpDetails details) {
    print('-----_onTapUp-localPosition:--${details.localPosition}------');
    print('-----_onTapUp-globalPosition:--${details.globalPosition}------');
    print('-----_onTapUp-kind:--${details.kind}------');
  }
}
