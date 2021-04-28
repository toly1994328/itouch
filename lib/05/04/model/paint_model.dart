import 'package:flutter/material.dart';

import 'line.dart';
import 'point.dart';

class PaintModel extends ChangeNotifier {
  List<Line> _lines = [];

  final double tolerance = 8.0;

  Line get activeLine =>
      _lines.singleWhere((element) => element.state == PaintState.doing,
          orElse: () => null);

  void pushLine(Line line) {
    _lines.add(line);
  }

  List<Line> get lines=>_lines;

  void pushPoint(Point point,{bool force = false}) {
    if (activeLine == null) return;

    if(activeLine.points.isNotEmpty&&!force){
      if((point-activeLine.points.last).distance<tolerance) return;
    }

    activeLine.points.add(point);
    notifyListeners();
  }

  void doneLine() {
    if (activeLine == null) return;
    print("doneLine---${lines.length}-----${lines[0].points.length}---");
    activeLine.state = PaintState.done;
    notifyListeners();
  }

  void clear(){
    _lines.forEach((element) => element.points.clear());
    _lines.clear();
    notifyListeners();
  }

  void removeEmpty() {
    _lines.removeWhere((element) => element.points.length==0);
  }
}
