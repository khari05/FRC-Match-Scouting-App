import 'package:flutter/material.dart';
import 'package:frc_scouting/models/scouting_data_model.dart';
import 'package:numberpicker/numberpicker.dart';

class NumberCard extends StatefulWidget {
  final ScoutingDataModel form;
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
            Flexible(child: Text(widget.text)),
            NumberPicker.integer(
                minValue: 0,
                maxValue: 60,
                initialValue: value,
                onChanged: (newValue) {
                  setState(() {
                    value = newValue;
                    widget.form.edit(widget.value, newValue);
                  });
                }),
          ],
        ),
      ),
    );
  }
}

class CheckBoxCard extends StatefulWidget {
  final ScoutingDataModel form;
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
            Flexible(child: Text(widget.text)),
            Checkbox(
                value: widget.form.view(widget.value),
                onChanged: (newValue) => {
                      setState(() {
                        widget.form.edit(widget.value, newValue);
                      })
                    }),
          ],
        ),
      ),
    );
  }
}

class HangDropdown extends StatefulWidget {
  final ScoutingDataModel form;
  HangDropdown(this.form);

  @override
  _HangDropdownState createState() => _HangDropdownState();
}

class _HangDropdownState extends State<HangDropdown> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButton<dynamic>(
          hint: Text("Hanging"),
          value: widget.form.hanging,
          items: [
            DropdownMenuItem(
              child: Text("Didn't Hang"),
              value: 0,
            ),
            DropdownMenuItem(
              child: Text("Hung on the side/middle"),
              value: 1,
            ),
          ],
          onChanged: (newValue) => {
            setState(() {
              widget.form.hanging = newValue.toDouble();
            })
          },
        ),
      ),
    );
  }
}
