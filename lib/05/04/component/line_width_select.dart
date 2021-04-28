import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

typedef LineWidthCallback = void Function(double width);

class LineWidthSelect extends StatefulWidget {
  final List<double> numbers;
  final double width;
  final LineWidthCallback onLineWidthSelect;
  final double defaultWidth;

  LineWidthSelect(
      {this.numbers, this.width = 25,this.defaultWidth, @required this.onLineWidthSelect});

  @override
  _LineWidthSelectState createState() => _LineWidthSelectState();
}

class _LineWidthSelectState extends State<LineWidthSelect> {
  int _selectIndex = 0;

  double get activeWidth => widget.numbers[_selectIndex];

  @override
  void initState() {
    super.initState();
    if (widget.defaultWidth != null) {
      _selectIndex = widget.numbers.indexOf(widget.defaultWidth);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 45,
      child: Wrap(
        spacing: 20,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: widget.numbers.map((e) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _doSelectWidth(e),
            child: _buildItem(e),
          )).toList(),
      ),
    );
  }

  Widget _buildItem(double width) => Container(
    alignment: Alignment.center,
    height: widget.width,
    width: widget.width,
    padding: EdgeInsets.all(5),
    decoration: activeWidth==width? BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.blue),
      borderRadius: BorderRadius.circular(5)
    ):null,
    child: Container(
          height: width,
          decoration: BoxDecoration(
            color: Colors.black,
          ),
        ),
  );

  void _doSelectWidth(double width) {
    int index = widget.numbers.indexOf(width);
    if (index == _selectIndex) return;
    setState(() {
      _selectIndex = index;
    });
    widget.onLineWidthSelect?.call(width);
  }
}
