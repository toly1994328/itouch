import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/gestures/events.dart';

void main() {
  runApp(Directionality(
      textDirection: TextDirection.ltr,
      child: ListenerDemo()));
}

class ListenerDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _onPointerDown,
      onPointerHover: _onPointerHover,
      onPointerCancel: _onPointerCancel,
      onPointerSignal: _onPointerSignal,
      onPointerMove: _onPointerMove,
      onPointerUp: _onPointerUp,
      child: ColoredBox(color: Colors.blue,),
    );
  }

  void _onPointerDown(PointerDownEvent event) {
    debugDumpRenderTree();
      print('-----_onPointerDown------${event.toStringShort()}---------');
  }

  void _onPointerHover(PointerHoverEvent event) {
    print('-----_onPointerHover------${event.toStringShort()}---------');

  }

  void _onPointerCancel(PointerCancelEvent event) {
    print('-----_onPointerCancel------${event.toStringShort()}---------');

  }

  void _onPointerSignal(PointerSignalEvent event) {
    print('-----_onPointerSignal------${event.toStringShort()}---------');
  }

  void _onPointerMove(PointerMoveEvent event) {
    print('-----_onPointerMove------${event.toStringShort()}---------');
  }

  void _onPointerUp(PointerUpEvent event) {
    print('-----_onPointerUp------${event.toStringShort()}---------');
  }
}

