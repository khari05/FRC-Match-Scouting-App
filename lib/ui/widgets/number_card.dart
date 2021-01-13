import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frc_scouting/blocs/blocs.dart';
import 'package:frc_scouting/models/models.dart';
import 'package:numberpicker/numberpicker.dart';

class NumberCard extends StatelessWidget {
  final ScoutingData form;
  final String value;
  final int index;
  final String text;
  NumberCard(this.form, this.value, this.index, this.text);

  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(child: Text(text)),
            NumberPicker.integer(
              minValue: 0,
              maxValue: 60,
              initialValue: index,
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
