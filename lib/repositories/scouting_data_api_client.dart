import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frc_scouting/main.dart';
import 'package:frc_scouting/models/models.dart';
import 'package:http/http.dart' as http;

class ScoutingDataApiClient {
  final http.Client httpClient;

  ScoutingDataApiClient({@required this.httpClient})
      : assert(httpClient != null);

  Future<ScoutingData> fetchScoutingData(int teamNumber, int matchId) async {
    final http.Response formResponse =
        await http.get("$baseUrl/scout/$teamNumber/$matchId");

    if (formResponse.statusCode != 200) {
      throw Exception('Error loading scouting form');
    }

    if (formResponse.body != "") {
      return ScoutingData.fromJson(
        json: json.decode(formResponse.body)["data"],
        teamNumber: teamNumber,
        matchId: matchId,
      );
    } else {
      return ScoutingData(teamNumber: teamNumber, matchId: matchId);
    }
  }
}
