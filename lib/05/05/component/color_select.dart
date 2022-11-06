import 'package:flutter/material.dart';

typedef ColorSelectCallback = void Function(Color color);

class ColorSelect extends StatefulWidget {
  final List<Color> colors;
  final double radius;
  final Color defaultColor;
  final ColorSelectCallback onColorSelect;

  ColorSelect(
      {required this.colors,
      this.radius = 25,
        required this.defaultColor,
      required this.onColorSelect});

  @override
  _ColorSelectState createState() => _ColorSelectState();
}

class _ColorSelectState extends State<ColorSelect> {
  int _selectIndex = 0;

  Color get activeColor => widget.colors[_selectIndex];

  @override
  void initState() {
    super.initState();
    if (widget.defaultColor != null) {
      _selectIndex = widget.colors.indexOf(widget.defaultColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 45,
      child: Wrap(
        spacing: 20,
        children: widget.colors.map((e) {
          return GestureDetector(
            onTap: () => _doSelectColor(e),
            child: _buildItem(e),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildItem(Color color) => Container(
      width: widget.radius,
      height: widget.radius,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: activeColor == color ? _buildActiveIndicator() : null);

  Widget _buildActiveIndicator() => Container(
      width: widget.radius * 0.6,
      height: widget.radius * 0.6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ));

  void _doSelectColor(Color e) {
    int index = widget.colors.indexOf(e);
    if (index == _selectIndex) return;
    setState(() {
      _selectIndex = index;
    });
    widget.onColorSelect?.call(e);
  }
}
