import 'package:flutter/material.dart';

import 'package:color/util/color_util.dart';
import 'package:color/input/bar_input.dart';

class RGBSelector extends StatefulWidget {
  const RGBSelector({Key? key, required this.setColor, required this.initColor})
      : super(key: key);

  final Function setColor;
  final ColorUtil initColor;

  @override
  State<RGBSelector> createState() => _RGBSelectorState();
}

class _RGBSelectorState extends State<RGBSelector> {
  List<int> _rgb = [0, 0, 0]; //R, G, B

  ColorUtil get color => ColorUtil().fromRGB(_rgb[0], _rgb[1], _rgb[2]);

  void setValue(int index, int value) {
    setState(() {
      _rgb[index] = value;
      widget.setColor(color);
    });
  }

  @override
  void initState() {
    super.initState();
    _rgb = widget.initColor.toRGB();
  }

  @override
  Widget build(BuildContext context) {
    final List<int> initRGB = widget.initColor.toRGB();
    return Column(
      children: [
        BarInput(
          name: 'R',
          max: 255,
          color: Colors.red,
          callback: (v) {
            setValue(0, v);
          },
          initValue: initRGB[0],
        ),
        BarInput(
          name: 'G',
          max: 255,
          color: Colors.green,
          callback: (v) {
            setValue(1, v);
          },
          initValue: initRGB[1],
        ),
        BarInput(
          name: 'B',
          max: 255,
          color: Colors.blue,
          callback: (v) {
            setValue(2, v);
          },
          initValue: initRGB[2],
        ),
      ],
    );
  }
}
