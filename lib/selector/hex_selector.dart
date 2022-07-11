import 'package:flutter/material.dart';

import 'package:color/util/color_util.dart';
import 'package:color/input/text_input.dart';

class HexSelector extends StatefulWidget {
  const HexSelector({Key? key, required this.setColor, required this.initColor})
      : super(key: key);

  final Function setColor;
  final ColorUtil initColor;

  @override
  State<HexSelector> createState() => _HexSelectorState();
}

class _HexSelectorState extends State<HexSelector> {
  String _hex = '000000'; //R, G, B

  ColorUtil get color => ColorUtil().fromHex(_hex);

  void setValue(String value) {
    setState(() {
      _hex = value;
      widget.setColor(color);
    });
  }

  @override
  void initState() {
    super.initState();
    _hex = widget.initColor.toHex();
  }

  @override
  Widget build(BuildContext context) {
    final String initHex = widget.initColor.toHex();
    return Center(
      child: TextInput(
        name: 'Hex',
        color: color.toColor(),
        callback: setValue,
        initValue: '#$initHex',
      ),
    );
  }
}
