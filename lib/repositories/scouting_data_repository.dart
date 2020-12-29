import 'package:flutter/material.dart';
import 'package:frc_scouting/models/models.dart';
import 'package:frc_scouting/repositories/scouting_data_api_client.dart';

class ScoutingDataRepository {
  final ScoutingDataApiClient scoutingDataApiClient;

  ScoutingDataRepository({@required this.scoutingDataApiClient})
      : assert(scoutingDataApiClient != null);

  Future<ScoutingData> getForm(int teamNumber, int matchId) {
    return scoutingDataApiClient.fetchScoutingData(teamNumber, matchId);
  }
}
