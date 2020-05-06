import 'package:flutter/material.dart';
import 'package:frc_scouting/classes/ScoutData.dart';
import 'package:numberpicker/numberpicker.dart';

class NumberCard extends StatefulWidget {
  final ScoutData form;
  final String value;
  final String text;
  NumberCard(this.form, this.value, this.text);

  @override
  _NumberCardState createState() => _NumberCardState();
}

class _NumberCardState extends State<NumberCard> {
  @override
  Widget build(BuildContext context) {
    int value = widget.form.view(widget.value);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(widget.text),
            NumberPicker.integer(
              minValue: 0,
              maxValue: 60,
              initialValue: value,
              onChanged: (newValue) {
                setState(() {
                  value = newValue;
                  widget.form.edit(widget.value, newValue);
                });
              }
            ),
          ],
        ),
      ),
    );
  }
}

class CheckBoxCard extends StatefulWidget {
  final ScoutData form;
  final String value;
  final String text;
  CheckBoxCard(this.form, this.value, this.text);

  @override
  _CheckBoxCardState createState() => _CheckBoxCardState();
}

class _CheckBoxCardState extends State<CheckBoxCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(widget.text),
            Checkbox(
              value: widget.form.view(widget.value),
              onChanged: (newValue) => {
                setState(() {
                  widget.form.edit(widget.value, newValue);
                })
              }
            ),
          ],
        ),
      ),
    );
  }
}
