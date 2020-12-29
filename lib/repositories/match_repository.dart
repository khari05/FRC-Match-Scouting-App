import 'package:flutter/material.dart';
import 'package:frc_scouting/models/models.dart';
import 'package:frc_scouting/repositories/match_api_client.dart';

class MatchRepository {
  final MatchApiClient matchApiClient;

  MatchRepository({@required this.matchApiClient})
      : assert(matchApiClient != null);

  Future<List<MatchObject>> getMatches(String blueAllianceId) {
    return matchApiClient.fetchMatchList(blueAllianceId);
  }
}
