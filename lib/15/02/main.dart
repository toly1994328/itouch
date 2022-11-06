import 'dart:developer';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/gestures/events.dart';

void main() {
  runApp(
      Directionality(textDirection: TextDirection.ltr, child: ListenerDemo()));
}

class ListenerDemo extends StatefulWidget {
  @override
  _ListenerDemoState createState() => _ListenerDemoState();
}

class _ListenerDemoState extends State<ListenerDemo> {

  final PointerTrack track= PointerTrack();

  @override
  void initState() {
    super.initState();
    track.startTrackingPointOne();
  }

  @override
  void dispose() {
    track.stopTrackingPointOne();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue,
    );
  }
}

class PointerTrack {

  startTrackingPointOne(){
    GestureBinding.instance!.pointerRouter.addRoute(1, handleMyEvent);
  }

  stopTrackingPointOne(){
    GestureBinding.instance!.pointerRouter.removeRoute(1, handleMyEvent);
  }

  void handleMyEvent(PointerEvent event) {
    print("=========${event.runtimeType}=======${Timeline.now}=====");
  }
}
