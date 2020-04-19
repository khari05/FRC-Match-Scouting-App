import 'package:flutter/material.dart';
import 'package:frc_scouting/classes/ScoutData.dart';
import 'package:frc_scouting/main.dart';
import 'package:frc_scouting/widgets/scoutingform/stateful.dart';
import 'package:http/http.dart' as http;

Widget scoutingPage(BuildContext context, ScoutData form) {
  return Scaffold(
    appBar: AppBar(title: Text("Scouting Team #" + form.teamNumber.toString())),
    body: Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            Text("Autonomous", style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            checkBoxCard(form.autonLine, "Does the team get off of the line?"),
            checkBoxCard(form.autonLow, "Does the team score in the low goal?"),
            checkBoxCard(form.autonHigh, "Does the team score in the high goal?"),
            numberCard(form.totalAutonScored, "Total balls scored during autonomous"),
            numberCard(form.totalAutonAttempted, "Total balls attempted to be scored\nduring autonomous"),
            Text("TeleOp", style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            numberCard(form.lowScored, "Total scored in the low goal"),
            numberCard(form.outerScored, "Total scored in the outer goal"),
            numberCard(form.innerScored, "Total scored in the inner goal"),
            numberCard(form.attemptedLowScored, "Total attempted to score in the low goal"),
            numberCard(form.attemptedHighScored, "Total attempted to score in the high goal"),
          ],
        ),
      ),
    ),
    floatingActionButton: FloatingActionButton(child: Icon(Icons.save), onPressed: () => {
      http.post(url + "/scout/", body: form.toJsonString())
    }),
  );
}

Widget numberCard(int number, String text) {
  return Card(
    child: Padding(
      padding: EdgeInsets.only(left:15, right:5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(text),
          NumberChooser(number)
        ],
      ),
    )
  );
}

Widget checkBoxCard(bool boolean, String text) {
  return Card(
    child: CustomCheckBox(boolean, text),
  );
}