import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frc_scouting/classes/ScoutData.dart';
import 'package:frc_scouting/main.dart';
import 'package:frc_scouting/widgets/scoutingform/scoutingPage.dart';
import 'package:http/http.dart' as http;

Widget scoutingView(BuildContext context, int teamNumber, int matchId) {
  Future<http.Response> _scout = http.get(url + "/scout/", headers: {
    "team_number":teamNumber.toString(),
    "matchid":matchId.toString(),
  });
  return FutureBuilder(
    future: _scout,
    builder: (BuildContext context, AsyncSnapshot<http.Response> response) {
      if (response.hasData && response.data.body != "") {
        return scoutingPage(context, ScoutData(jsonDecode(response.data.body)["data"], teamNumber, matchId));
      } else if (response.hasError) {
        print("response has an error: " + response.error.toString());
        return Scaffold();
      } else {
        print("error: no data");
        return scoutingPage(context, ScoutData(jsonDecode("{}"), teamNumber, matchId));
      }
    }
  );
}