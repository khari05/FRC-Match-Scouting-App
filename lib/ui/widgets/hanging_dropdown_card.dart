import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frc_scouting/blocs/blocs.dart';
import 'package:frc_scouting/models/models.dart';

class HangDropdown extends StatelessWidget {
  final ScoutingData form;
  HangDropdown(this.form);

  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            DropdownButton<dynamic>(
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
                BlocProvider.of<ScoutingFormBloc>(context).add(FormDataChanged(
                  newForm: ScoutingData.edit(form, "hanging", newValue),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
