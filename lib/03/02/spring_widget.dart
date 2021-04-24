import 'package:flutter/material.dart';

import 'spring_painter.dart';

class SpringWidget extends StatefulWidget {
  @override
  _SpringWidgetState createState() => _SpringWidgetState();
}


const double _kDefaultSpringHeight = 100; //弹簧默认高度
const double _kRateOfMove = 1.5; //移动距离与形变量比值

class _SpringWidgetState extends State<SpringWidget> {

  ValueNotifier<double> height = ValueNotifier(_kDefaultSpringHeight);
  double s = 0; // 移动距离

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: _updateHeight,
      child: Container(
        width: 200,
        height: 200,
        color: Colors.grey.withAlpha(11),
        child: CustomPaint(
            painter: SpringPainter(height: height)),
      ),
    );
  }

  double get dx => -s/_kRateOfMove;

  void _updateHeight(DragUpdateDetails details) {
    s += details.delta.dy;
    height.value = _kDefaultSpringHeight + dx;
  }

  @override
  void dispose() {
    height.dispose();
    super.dispose();
  }

}
