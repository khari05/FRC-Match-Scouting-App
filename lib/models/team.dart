import 'package:frc_scouting/models/chart_data.dart';

class Team {
  int teamNumber;
  String teamName;
  String eventKey;

  String strengths;
  String flaws;
  String strategies;

  double opr;
  double dpr;

  double avgLow;
  double avgOuter;
  double avgInner;
  double avgTotal;
  double avgAttempted;

  List<ChartData> lowScored;
  List<ChartData> outerScored;
  List<ChartData> innerScored;
  List<ChartData> totalScored;
  List<ChartData> totalAttempted;

  double avgPen;
  double avgHang;

  List<ChartData> penalties;
  List<ChartData> hanging;

  Team.fromJson(Map<String, dynamic> json) {
    teamNumber = json["team_number"];
    teamName = json["team_name"];
    eventKey = json["blue_alliance_id"];

    strengths = (json["data"] != null && json["data"]["strengths"] != null)
        ? json["data"]["strengths"]
        : null;
    flaws = (json["data"] != null && json["data"]["flaws"] != null)
        ? json["data"]["flaws"]
        : null;
    strategies = (json["data"] != null && json["data"]["strategies"] != null)
        ? json["data"]["strategies"]
        : null;

    opr = (json["data"] != null && json["data"]["opr"] != null)
        ? json["data"]["opr"].toDouble()
        : 0.toDouble();
    dpr = (json["data"] != null && json["data"]["dpr"] != null)
        ? json["data"]["dpr"].toDouble()
        : 0.toDouble();

    avgLow = (json["data"] != null)
        ? json["data"]["avgLow"].toDouble()
        : 0.toDouble();
    avgOuter = (json["data"] != null)
        ? json["data"]["avgOuter"].toDouble()
        : 0.toDouble();
    avgInner = (json["data"] != null)
        ? json["data"]["avgInner"].toDouble()
        : 0.toDouble();
    avgTotal = (json["data"] != null)
        ? json["data"]["avgTotal"].toDouble()
        : 0.toDouble();
    avgAttempted = (json["data"] != null)
        ? json["data"]["avgAttempted"].toDouble()
        : 0.toDouble();

    lowScored = ChartData.fromJson(
        (json["data"] != null) ? json["data"]["lowScored"] : []);
    outerScored = ChartData.fromJson(
        (json["data"] != null) ? json["data"]["outerScored"] : []);
    innerScored = ChartData.fromJson(
        (json["data"] != null) ? json["data"]["innerScored"] : []);
    totalScored = ChartData.fromJson(
        (json["data"] != null) ? json["data"]["totalScored"] : []);
    totalAttempted = ChartData.fromJson(
        (json["data"] != null) ? json["data"]["totalAttempted"] : []);

    avgPen = (json["data"] != null && json["data"]["avgPen"] != null)
        ? json["data"]["avgPen"].toDouble()
        : 0.toDouble();
    avgHang = (json["data"] != null && json["data"]["avgHang"] != null)
        ? json["data"]["avgHang"].toDouble()
        : 0.toDouble();

    penalties = ChartData.fromJson(
        (json["data"] != null) ? json["data"]["penalties"] : []);
    hanging = ChartData.fromJson(
        (json["data"] != null) ? json["data"]["hanging"] : []);
  }

  Map<String, dynamic> toJson() {
    return {
      "strengths": strengths,
      "flaws": flaws,
      "strategies": strategies,
    };
  }

  getValue(int value) {
    switch (value) {
      case 0:
        return teamNumber;
        break;
      case 1:
        return opr;
        break;
      case 2:
        return dpr;
        break;
      case 3:
        return avgLow;
        break;
      case 4:
        return avgOuter;
        break;
      case 5:
        return avgInner;
        break;
      case 6:
        return avgPen;
        break;
      case 7:
        return avgHang;
        break;
    }
  }
}
