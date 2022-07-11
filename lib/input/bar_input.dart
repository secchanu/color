import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:math' as math;

class BarInput extends StatefulWidget {
  const BarInput(
      {Key? key,
      required this.name,
      required this.max,
      required this.color,
      required this.callback,
      required this.initValue})
      : super(key: key);

  final String name;
  final int max;
  final Color color;
  final Function callback;
  final int initValue;

  @override
  State<BarInput> createState() => _BarInputState();
}

class _BarInputState extends State<BarInput> {
  double _value = 0;

  get value => _value.round();

  final _editingController = TextEditingController(text: '0');

  void setValue(double v) {
    setState(() {
      _editingController.text = v.round().toString();
      _value = v;
      widget.callback(v.round());
    });
  }

  @override
  void initState() {
    super.initState();
    _value = widget.initValue.toDouble();
    _editingController.text = widget.initValue.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 75,
          child: Text(
            widget.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        Expanded(
          child: Focus(
            descendantsAreFocusable: false,
            child: Slider(
              value: _value,
              divisions: widget.max,
              max: widget.max.toDouble(),
              label: _value.round().toString(),
              onChanged: (double v) {
                setValue(v);
              },
              activeColor: widget.color,
              thumbColor: widget.color,
            ),
          ),
        ),
        SizedBox(
          width: 100,
          child: TextField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.color,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.color,
                ),
              ),
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            controller: _editingController,
            onChanged: (String s) {
              final int ps = int.tryParse(s) ?? 0;
              final double v = math.min(ps, widget.max).toDouble();
              if (ps > v) {
                setValue(v);
              } else {
                setState(() {
                  _value = v;
                  widget.callback(v.round());
                });
              }
            },
          ),
        ),
      ],
    );
  }
}
