import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class NumberChooser extends StatefulWidget {
  int value;
  NumberChooser(this.value);

  @override
  _NumberChooserState createState() => _NumberChooserState();
}

class _NumberChooserState extends State<NumberChooser> {
  @override
  Widget build(BuildContext context) {
    return NumberPicker.integer(
      initialValue: widget.value,
      minValue: 0,
      maxValue: 60,
      onChanged: (newValue) {
        setState(() {
          widget.value = newValue;
        });
      });
  }
}

class CustomCheckBox extends StatefulWidget {
  bool value;
  final String text;
  CustomCheckBox(this.value, this.text);

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.text),
      value: widget.value,
      onChanged: (newValue) => {
        setState(() {
          widget.value = newValue;
        })
      }
    );
  }
}
