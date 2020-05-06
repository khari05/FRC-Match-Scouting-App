import 'dart:convert';

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
            CheckBoxCard(form, "autonLine", "Does the team get off of the line?"),
            CheckBoxCard(form, "autonLow", "Does the team score in the low goal?"),
            CheckBoxCard(form, "autonHigh", "Does the team score in the high goal?"),
            NumberCard(form, "totalAutonScored", "Total balls scored during autonomous"),
            NumberCard(form, "totalAutonAttempted", "Total balls attempted to be scored\nduring autonomous"),
            Text("TeleOp", style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            NumberCard(form, "lowScored", "Total scored in the low goal"),
            NumberCard(form, "outerScored", "Total scored in the outer goal"),
            NumberCard(form, "innerScored", "Total scored in the inner goal"),
            NumberCard(form, "attemptedLowScored", "Total attempted to score in the low goal"),
            NumberCard(form, "attemptedHighScored", "Total attempted to score in the high goal"),
          ],
        ),
      ),
    ),
    floatingActionButton: FloatingActionButton(child: Icon(Icons.save), onPressed: () => {
      http.post("$url/scout/${form.teamNumber}/${form.matchId}", body: jsonEncode(form.toJsonString()), headers: {"Content-Type":"application/json"}),
      Navigator.pop(context)
    }),
  );
}

