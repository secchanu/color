import 'package:flutter/material.dart';

import 'package:color/util/color_util.dart';
import 'package:color/input/bar_input.dart';

class CMYKSelector extends StatefulWidget {
  const CMYKSelector(
      {Key? key, required this.setColor, required this.initColor})
      : super(key: key);

  final Function setColor;
  final ColorUtil initColor;

  @override
  State<CMYKSelector> createState() => _CMYKSelectorState();
}

class _CMYKSelectorState extends State<CMYKSelector> {
  List<double> _cmyk = [0.0, 0.0, 0.0, 0.0]; //C, M, Y,K

  ColorUtil get color =>
      ColorUtil().fromCMYK(_cmyk[0], _cmyk[1], _cmyk[2], _cmyk[3]);

  void setValue(int index, int value) {
    final double v = value / 100;
    setState(() {
      _cmyk[index] = v;
      widget.setColor(color);
    });
  }

  @override
  void initState() {
    super.initState();
    _cmyk = widget.initColor.toCMYK().map((e) => e.isNaN ? 0.0 : e).toList();
  }

  @override
  Widget build(BuildContext context) {
    final initCMYK =
        widget.initColor.toCMYK().map((e) => e.isNaN ? 0.0 : e).toList();
    return Column(
      children: [
        BarInput(
          name: 'C',
          max: 100,
          color: Colors.cyan,
          callback: (int v) {
            setValue(0, v);
          },
          initValue: (initCMYK[0] * 100).round(),
        ),
        BarInput(
          name: 'M',
          max: 100,
          color: const Color(0xFFEC008C),
          callback: (int v) {
            setValue(1, v);
          },
          initValue: (initCMYK[1] * 100).round(),
        ),
        BarInput(
          name: 'Y',
          max: 100,
          color: Colors.yellow,
          callback: (int v) {
            setValue(2, v);
          },
          initValue: (initCMYK[2] * 100).round(),
        ),
        BarInput(
          name: 'K',
          max: 100,
          color: Colors.black,
          callback: (int v) {
            setValue(3, v);
          },
          initValue: (initCMYK[3] * 100).round(),
        ),
      ],
    );
  }
}
