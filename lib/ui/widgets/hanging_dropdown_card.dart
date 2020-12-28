import 'package:flutter/material.dart';
import 'package:frc_scouting/models/models.dart';

class HangDropdown extends StatelessWidget {
  final ScoutingData form;
  HangDropdown(this.form);

  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButton<dynamic>(
          hint: Text("Hanging"),
          value: form.hanging,
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
          onChanged: (newValue) {
            // TODO update state
            // BlocProvider.of<ScoutingFormBloc>(context).add()
            ScoutingData.edit(form, "hanging", newValue);
          },
        ),
      ),
    );
  }
}
