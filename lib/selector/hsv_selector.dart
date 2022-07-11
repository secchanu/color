import 'package:flutter/material.dart';

import 'package:color/util/color_util.dart';
import 'package:color/input/bar_input.dart';

class HSVSelector extends StatefulWidget {
  const HSVSelector({Key? key, required this.setColor, required this.initColor})
      : super(key: key);

  final Function setColor;
  final ColorUtil initColor;

  @override
  State<HSVSelector> createState() => _HSVSelectorState();
}

class _HSVSelectorState extends State<HSVSelector> {
  List<num> _hsv = [0, 0.0, 0.0]; //H, S, V

  ColorUtil get color =>
      ColorUtil().fromHSV(_hsv[0] as int, _hsv[1] as double, _hsv[2] as double);

  void setValue(int index, int value) {
    setState(() {
      _hsv[index] = index == 0 ? value : value / 100;
      widget.setColor(color);
    });
  }

  @override
  void initState() {
    super.initState();
    _hsv = widget.initColor.toHSV().map((e) => e.isNaN ? 0.0 : e).toList();
  }

  @override
  Widget build(BuildContext context) {
    final List<num> initHSV =
        widget.initColor.toHSV().map((e) => e.isNaN ? 0.0 : e).toList();
    return Column(
      children: [
        BarInput(
          name: 'H',
          max: 359,
          color: Colors.red,
          callback: (v) {
            setValue(0, v);
          },
          initValue: initHSV[0].round(),
        ),
        BarInput(
          name: 'S',
          max: 100,
          color: Colors.green,
          callback: (v) {
            setValue(1, v);
          },
          initValue: (initHSV[1] * 100).round(),
        ),
        BarInput(
          name: 'V',
          max: 100,
          color: Colors.blue,
          callback: (v) {
            setValue(2, v);
          },
          initValue: (initHSV[2] * 100).round(),
        ),
      ],
    );
  }
}
