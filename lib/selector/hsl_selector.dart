import 'package:flutter/material.dart';

import 'package:color/util/color_util.dart';
import 'package:color/input/bar_input.dart';

class HSLSelector extends StatefulWidget {
  const HSLSelector({Key? key, required this.setColor, required this.initColor})
      : super(key: key);

  final Function setColor;
  final ColorUtil initColor;

  @override
  State<HSLSelector> createState() => _HSLSelectorState();
}

class _HSLSelectorState extends State<HSLSelector> {
  List<num> _hsl = [0, 0.0, 0.0]; //H, S, L

  ColorUtil get color =>
      ColorUtil().fromHSL(_hsl[0] as int, _hsl[1] as double, _hsl[2] as double);

  void setValue(int index, int value) {
    setState(() {
      _hsl[index] = index == 0 ? value : value / 100;
      widget.setColor(color);
    });
  }

  @override
  void initState() {
    super.initState();
    _hsl = widget.initColor.toHSL().map((e) => e.isNaN ? 0.0 : e).toList();
  }

  @override
  Widget build(BuildContext context) {
    final List<num> initHSL =
        widget.initColor.toHSL().map((e) => e.isNaN ? 0.0 : e).toList();
    return Column(
      children: [
        BarInput(
          name: 'H',
          max: 359,
          color: Colors.red,
          callback: (v) {
            setValue(0, v);
          },
          initValue: initHSL[0].round(),
        ),
        BarInput(
          name: 'S',
          max: 100,
          color: Colors.green,
          callback: (v) {
            setValue(1, v);
          },
          initValue: (initHSL[1] * 100).round(),
        ),
        BarInput(
          name: 'L',
          max: 100,
          color: Colors.blue,
          callback: (v) {
            setValue(2, v);
          },
          initValue: (initHSL[2] * 100).round(),
        ),
      ],
    );
  }
}
