import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frc_scouting/classes/ScoutData.dart';
import 'package:frc_scouting/main.dart';
import 'package:frc_scouting/widgets/scoutingform/stateful.dart';
import 'package:frc_scouting/widgets/TeamView.dart';
import 'package:http/http.dart' as http;

class ScoutingPage extends StatelessWidget {
  final ScoutData form;
  final String eventKey;

  const ScoutingPage({Key key, @required this.form, @required this.eventKey}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scouting Team #${form.teamNumber}"),
        actions: [FlatButton(
          child: Icon(Icons.person),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) {
                return TeamView(teamNumber: form.teamNumber, eventKey: eventKey,);
              }
            ));
          }
        )]
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top:16,left:8,right:8,bottom:8),
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
              Text("End Game", style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              CheckBoxCard(form, "colorSpin", "Does the team spin the Control Panel? (stage 2)"),
              CheckBoxCard(form, "colorSelect", "Does the team spin the Control Panel\nto a specific color? (stage 3)"),
              HangDropdown(form),
              NumberCard(form, "amountOfStucks", "Number of times the robot gets stuck"),
              NumberCard(form, "amountOfPenalties", "Number of penalties the team gets")
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.save), onPressed: () {
        http.post("$url/scout/${form.teamNumber}/${form.matchId}", body: jsonEncode(form.toJsonString()), headers: {"Content-Type":"application/json"});
        Navigator.pop(context);
      }),
    );
  }
}

