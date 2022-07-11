import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInput extends StatefulWidget {
  const TextInput(
      {Key? key,
      required this.name,
      required this.color,
      required this.callback,
      required this.initValue})
      : super(key: key);

  final String name;
  final Color color;
  final Function callback;
  final String initValue;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  String _value = '#';

  get value => _value.replaceAll('#', '');

  final _editingController = TextEditingController(text: '#');

  void setValue(String s) {
    setState(() {
      _value = s;
      widget.callback(value);
    });
  }

  @override
  void initState() {
    super.initState();
    _value = widget.initValue;
    _editingController.text = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
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
        keyboardType: TextInputType.visiblePassword,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^#?([0-9a-fA-F]{0,})$'))
        ],
        controller: _editingController,
        onChanged: (String s) {
          setValue(s);
        },
      ),
    );
  }
}
