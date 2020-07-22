import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frc_scouting/src/models/scouting_data_model.dart';
import 'package:frc_scouting/main.dart';
import 'package:frc_scouting/src/widgets/scoutingform/ScoutingPage.dart';
import 'package:http/http.dart' as http;

class ScoutingView extends StatelessWidget {
  final int teamNumber;
  final int matchId;
  final String eventKey;

  const ScoutingView(
      {Key key,
      @required this.teamNumber,
      @required this.matchId,
      @required this.eventKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<http.Response> _scout = http.get("$url/scout/$teamNumber/$matchId");
    return FutureBuilder(
        future: _scout,
        builder: (BuildContext context, AsyncSnapshot<http.Response> response) {
          if (response.hasData && response.data.body != "") {
            return ScoutingPage(
              form: ScoutingDataModel.fromJson(
                json: jsonDecode(response.data.body)["data"],
                teamNumber: teamNumber,
                matchId: matchId,
              ),
              eventKey: eventKey,
            );
          } else if (response.hasData && response.data.body == "") {
            return ScoutingPage(
                form: ScoutingDataModel(teamNumber: teamNumber, matchId: matchId),
                eventKey: eventKey);
          } else if (response.hasError) {
            print("response has an error: " + response.error.toString());
            return Scaffold();
          } else {
            print("error: no data");
            return Scaffold(
                appBar: AppBar(title: Text("Scouting Team #$teamNumber")),
                body: Center(
                  child: CircularProgressIndicator(),
                ));
          }
        });
  }
}
