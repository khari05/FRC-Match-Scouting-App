import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frc_scouting/main.dart';
import 'package:frc_scouting/models/models.dart';
import 'package:http/http.dart' as http;

class TeamApiClient {
  final http.Client httpClient;

  TeamApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<List<Team>> fetchTeamList(String blueAllianceId) async {
    final http.Response teamResponse =
        await httpClient.get("$baseUrl/teams/$blueAllianceId");

    if (teamResponse.statusCode != 200) {
      throw Exception("Error loading matches");
    }

    List<Team> teams = [];
    json.decode(teamResponse.body).forEach((element) {
      teams.add(Team.fromJson(element));
    });
    return teams;
  }
}
