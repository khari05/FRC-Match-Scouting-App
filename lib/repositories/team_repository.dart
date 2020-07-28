import 'package:flutter/material.dart';
import 'package:frc_scouting/models/models.dart';
import 'package:frc_scouting/repositories/team_api_client.dart';

class TeamRepository {
  final TeamApiClient teamApiClient;

  TeamRepository({@required this.teamApiClient})
      : assert(teamApiClient != null);

  Future<List<Team>> getTeams(String blueAllianceId) {
    return teamApiClient.fetchTeamList(blueAllianceId);
  }
}
