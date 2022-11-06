import 'package:flutter/material.dart';

import 'color_select.dart';
import 'line_width_select.dart';

const List<Color> _kColorSupport = [
  Colors.black,
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.blue,
  Colors.indigo,
  Colors.purple
];

const List<double> _kWidthSupport = [1.0, 3.0, 5.0, 6.0, 8.0, 9.0, 12.0,15.0];

class PaintSettingDialog extends StatelessWidget {
  final LineWidthCallback onLineWidthSelect;
  final ColorSelectCallback onColorSelect;
  final Color initColor;
  final double initWidth;

  PaintSettingDialog({
    required this.onLineWidthSelect,
    required this.onColorSelect,
    this.initColor=Colors.black,
    this.initWidth= 1,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildColorSelect(),
              Divider(height: 1,),
              _buildLineWidthSelect(),
              Container(
                color: Color(0xffE5E3E4).withOpacity(0.3),
                height: 10,
              ),
              _buildCancel(context)
            ],
          )),
    );
  }

  Widget _buildCancel(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: Ink(
          width: MediaQuery.of(context).size.width,
          height: 50,
          color: Colors.white,
          child: Center(
              child: Text(
            '取消',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }

  Widget _buildColorSelect() {
    return ColorSelect(
      defaultColor: initColor,
      colors: _kColorSupport,
      onColorSelect: onColorSelect,
    );
  }

  Widget _buildLineWidthSelect() {
    return LineWidthSelect(
      defaultWidth: initWidth,
      numbers: _kWidthSupport,
      onLineWidthSelect: onLineWidthSelect,
    );
  }
}
