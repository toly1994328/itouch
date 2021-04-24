import 'package:flutter/material.dart';

import 'spring_painter.dart';

class SpringWidget extends StatefulWidget {
  @override
  _SpringWidgetState createState() => _SpringWidgetState();
}

const double _kDefaultSpringHeight = 100; //弹簧默认高度
const double _kRateOfMove = 1.5; //移动距离与形变量比值

const double _kK = 3;

class _SpringWidgetState extends State<SpringWidget> with SingleTickerProviderStateMixin {
  ValueNotifier<double> height = ValueNotifier(_kDefaultSpringHeight);

  AnimationController _ctrl;


  double s = 0;  // 移动距离
  double laseMoveLen = 0;

  Animation<double> animation;

  final Duration animDuration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: animDuration)
      ..addListener(_updateHeightByAnim);
    // animation = CurvedAnimation(parent: _ctrl, curve: Curves.bounceOut);
    animation = CurvedAnimation(parent: _ctrl, curve: const Interpolator());
  }

  void _updateHeightByAnim() {
    s = laseMoveLen * (1 - animation.value);
    height.value = _kDefaultSpringHeight + (-s / _kRateOfMove);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    height.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: _updateSpace,
      onVerticalDragEnd: _animateToDefault,
      child: Container(
            width: 200,
            height: 200,
            color: Colors.grey.withAlpha(11),
            child: CustomPaint(
                painter: SpringPainter(height: height)),
      ),
    );
  }

  double f = 0;

  void _updateSpace(DragUpdateDetails details) {
    s += details.delta.dy;
    height.value = _kDefaultSpringHeight + dx;
  }

  double get dx => -s / _kRateOfMove;

  double get k => _kK;

  // void _reset(DragEndDetails details) {
  //
  //   f = k * dx;
  //   print('----[弹性系数:$_kK]---[移动了:$dx]----[可提供弹力:$f]------------');
  //   _animateToDefault();
  // }

  void _animateToDefault(DragEndDetails details) {
    laseMoveLen = s;
    _ctrl.forward(from: 0);
  }
}

class Interpolator extends Curve {
  const Interpolator();

  @override
  double transformInternal(double t) {
    t -= 1.0;
    return t * t * t * t * t + 1.0;
  }
}
