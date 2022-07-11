import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

import 'package:color/util/color_util.dart';

class DisplayOutput extends StatefulWidget {
  const DisplayOutput({Key? key, required this.color}) : super(key: key);

  final ColorUtil color;

  @override
  State<DisplayOutput> createState() => _DisplayOutputState();
}

class _DisplayOutputState extends State<DisplayOutput> {
  String _template = r'#${hex}';

  final _editingController = TextEditingController(text: r'#${hex}');

  void setTemplate(s) {
    setState(() {
      _template = s;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final String text = widget.color.getString(_template);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 300,
          child: TextField(
            textAlign: TextAlign.center,
            controller: _editingController,
            onChanged: (String s) {
              setTemplate(s);
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            final data = ClipboardData(text: text);
            Clipboard.setData(data);
          },
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Container(
                    width: math.max(screenSize.width * 0.3, 100),
                    height: screenSize.height * 0.2,
                    color: widget.color.toColor(),
                  ),
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              Expanded(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
