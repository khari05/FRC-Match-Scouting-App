import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frc_scouting/blocs/blocs.dart';
import 'package:frc_scouting/models/models.dart';

class CheckboxCard extends StatelessWidget {
  final ScoutingData form;
  final String value;
  final bool checked;
  final String text;
  CheckboxCard(this.form, this.value, this.checked, this.text);

  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(child: Text(text)),
            Checkbox(
              value: checked,
              onChanged: (newValue) {
                BlocProvider.of<ScoutingFormBloc>(context).add(FormDataChanged(
                  newForm: ScoutingData.edit(form, value, newValue),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
