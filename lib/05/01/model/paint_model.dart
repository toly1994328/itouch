import 'package:flutter/material.dart';

import 'line.dart';
import 'point.dart';

class PaintModel extends ChangeNotifier {
  List<Line> _lines = [];

  Line get activeLine =>
      _lines.singleWhere((element) => element.state == PaintState.doing,
          orElse: () => null);

  void pushLine(Line line) {
    _lines.add(line);
  }

  List<Line> get lines=>_lines;

  void pushPoint(Point point) {
    if (activeLine == null) return;
    activeLine.points.add(point);
    notifyListeners();
  }

  void doneLine() {
    if (activeLine == null) return;
    activeLine.state = PaintState.done;
    notifyListeners();
  }

  void clear(){
    _lines.forEach((line) => line.points.clear());
    _lines.clear();
    notifyListeners();
  }

  void removeEmpty() {
    _lines.removeWhere((element) => element.points.length == 0);
  }
}
