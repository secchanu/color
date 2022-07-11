import 'package:flutter/material.dart';

import 'package:color/util/color_util.dart';

import 'package:color/selector/rgb_selector.dart';
import 'package:color/selector/cmyk_selector.dart';
import 'package:color/selector/hex_selector.dart';
import 'package:color/selector/hsv_selector.dart';
import 'package:color/selector/hsl_selector.dart';

import 'package:color/output/display_output.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'co|or app',
      theme: ThemeData.dark(),
      home: const ColorSelector(title: 'co|or'),
    );
  }
}

class ColorSelector extends StatefulWidget {
  const ColorSelector({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  ColorUtil _color = ColorUtil();
  String _inputType = 'RGB';

  void setColor(ColorUtil color) {
    setState(() {
      _color = color;
    });
  }

  void setInputType(String type) {
    setState(() {
      _inputType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SizedBox(
          width: screenSize.width * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropdownButton(
                value: _inputType,
                items: <String>['RGB', 'Hex', 'CMYK', 'HSV', 'HSL']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? v) {
                  setInputType(v.toString());
                },
              ),
              (() {
                switch (_inputType) {
                  case 'RGB':
                    return RGBSelector(setColor: setColor, initColor: _color);
                  case 'Hex':
                    return HexSelector(setColor: setColor, initColor: _color);
                  case 'CMYK':
                    return CMYKSelector(setColor: setColor, initColor: _color);
                  case 'HSV':
                    return HSVSelector(setColor: setColor, initColor: _color);
                  case 'HSL':
                    return HSLSelector(setColor: setColor, initColor: _color);
                  default:
                    return RGBSelector(setColor: setColor, initColor: _color);
                }
              })(),
              DisplayOutput(color: _color),
            ],
          ),
        ),
      ),
    );
  }
}
