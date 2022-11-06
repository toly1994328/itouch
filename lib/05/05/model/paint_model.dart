import 'package:flutter/material.dart';

import 'line.dart';
import 'point.dart';

class PaintModel extends ChangeNotifier {
  List<Line> _lines = [];

  final double tolerance = 8.0;

  Line? get activeLine {
    try {
      return _lines.singleWhere((element) => element.state == PaintState.doing);
    } catch (e) {
      return null;
    }
  }

  Line? get editLine {
    try {
      return _lines.singleWhere((element) => element.state == PaintState.edit);
    } catch (e) {
      return null;
    }
  }


  void pushLine(Line line) {
    _lines.add(line);
  }

  List<Line> get lines => _lines;

  void pushPoint(Point point, {bool force = false}) {
    if (activeLine == null) return;

    if (activeLine!.points.isNotEmpty && !force) {
      if ((point - activeLine!.points.last).distance < tolerance) return;
    }

    activeLine!.points.add(point);
    notifyListeners();
  }

  void activeEditLine(Point point) {
    List<Line> lines =
        _lines.where((line) => line.path.getBounds().contains(point.toOffset())).toList();
    print(lines.length);
    if (lines.isNotEmpty) {
      lines[0].state = PaintState.edit;
      lines[0].recode();
      notifyListeners();
    }
  }

  void cancelEditLine() {
    _lines.forEach((element)=>element.state=PaintState.done);
    notifyListeners();
  }

  void moveEditLine(Offset offset) {
    if(editLine==null) return;
    editLine!.translate(offset);
    notifyListeners();
  }

  void doneLine() {
    if (activeLine == null) return;
    activeLine!.state = PaintState.done;
    notifyListeners();
  }

  void clear() {
    _lines.forEach((element) => element.points.clear());
    _lines.clear();
    notifyListeners();
  }

  void removeEmpty() {
    _lines.removeWhere((element) => element.points.length == 0);
  }
}
