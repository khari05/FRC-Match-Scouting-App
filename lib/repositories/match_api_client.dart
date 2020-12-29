import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frc_scouting/main.dart';
import 'package:frc_scouting/models/match_object.dart';
import 'package:http/http.dart' as http;

class MatchApiClient {
  final http.Client httpClient;

  MatchApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<List<MatchObject>> fetchMatchList(String blueAllianceId) async {
    final http.Response matchResponse =
        await httpClient.get("$baseUrl/matches/$blueAllianceId");

    if (matchResponse.statusCode != 200) {
      throw Exception("Error loading matches");
    }

    List<MatchObject> matches = [];
    json.decode(matchResponse.body).forEach((element) {
      matches.add(MatchObject.fromJson(element));
    });
    return matches;
  }
}
