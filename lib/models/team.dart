import 'package:equatable/equatable.dart';
import 'package:frc_scouting/models/chart_data.dart';

class Team extends Equatable {
  final int teamNumber;
  final String teamName;
  final String eventKey;

  final String strengths;
  final String flaws;
  final String strategies;

  final double opr;
  final double elo;

  final double avgLow;
  final double avgOuter;
  final double avgInner;
  final double avgTotal;
  final double avgAttempted;
  final int avgPercent;

  final List<ChartData> lowScored;
  final List<ChartData> outerScored;
  final List<ChartData> innerScored;
  final List<ChartData> totalScored;
  final List<ChartData> totalAttempted;
  final List<ChartData> percentScored;

  final double avgPen;
  final int avgHang;

  final List<ChartData> penalties;
  final List<ChartData> hanging;

  Team(
      {this.teamNumber,
      this.teamName,
      this.eventKey,
      this.strengths,
      this.flaws,
      this.strategies,
      this.opr,
      this.elo,
      this.avgLow,
      this.avgOuter,
      this.avgInner,
      this.avgTotal,
      this.avgAttempted,
      this.avgPercent,
      this.lowScored,
      this.outerScored,
      this.innerScored,
      this.totalScored,
      this.totalAttempted,
      this.percentScored,
      this.avgPen,
      this.avgHang,
      this.penalties,
      this.hanging});

  static Team fromJson(Map<String, dynamic> json) {
    double _avgTotal = (json["data"] != null)
        ? json["data"]["avgTotal"].toDouble()
        : 0.toDouble();
    double _avgAttempted = (json["data"] != null)
        ? json["data"]["avgAttempted"].toDouble()
        : 0.toDouble();

    List<ChartData> _totalAttempted = ChartData.fromJson(
        (json["data"] != null) ? json["data"]["totalAttempted"] : []);
    List<ChartData> _totalScored = ChartData.fromJson(
        (json["data"] != null) ? json["data"]["totalScored"] : []);

    List<ChartData> _percentScored = [];
    _totalAttempted.forEach((element) {
      _percentScored.add(ChartData(
          matchNumber: element.matchNumber,
          data: (_totalScored
                      .firstWhere((ChartData item) =>
                          item.matchNumber == element.matchNumber)
                      .data /
                  element.data)
              .round()));
    });

    return Team(
        teamNumber: json["team_number"],
        teamName: json["team_name"],
        eventKey: json["blue_alliance_id"],
        strengths: (json["data"] != null && json["data"]["strengths"] != null)
            ? json["data"]["strengths"]
            : null,
        flaws: (json["data"] != null && json["data"]["flaws"] != null)
            ? json["data"]["flaws"]
            : null,
        strategies: (json["data"] != null && json["data"]["strategies"] != null)
            ? json["data"]["strategies"]
            : null,
        opr: (json["data"] != null && json["data"]["opr"] != null)
            ? json["data"]["opr"].toDouble()
            : 0.toDouble(),
        elo: (json["data"] != null && json["data"]["elo"] != null)
            ? json["data"]["elo"].toDouble()
            : 0.toDouble(),
        avgLow: (json["data"] != null)
            ? json["data"]["avgLow"].toDouble()
            : 0.toDouble(),
        avgOuter: (json["data"] != null)
            ? json["data"]["avgOuter"].toDouble()
            : 0.toDouble(),
        avgInner: (json["data"] != null)
            ? json["data"]["avgInner"].toDouble()
            : 0.toDouble(),
        avgTotal: _avgTotal,
        avgAttempted: _avgAttempted,
        lowScored: ChartData.fromJson(
            (json["data"] != null) ? json["data"]["lowScored"] : []),
        outerScored: ChartData.fromJson(
            (json["data"] != null) ? json["data"]["outerScored"] : []),
        innerScored: ChartData.fromJson(
            (json["data"] != null) ? json["data"]["innerScored"] : []),
        totalScored: _totalScored,
        totalAttempted: _totalAttempted,
        avgPen: (json["data"] != null && json["data"]["avgPen"] != null)
            ? json["data"]["avgPen"].toDouble()
            : 0.toDouble(),
        avgHang: (json["data"] != null && json["data"]["avgHang"] != null)
            ? json["data"]["avgHang"].round()
            : 0,
        penalties: ChartData.fromJson(
            (json["data"] != null) ? json["data"]["penalties"] : []),
        hanging: ChartData.fromJson(
            (json["data"] != null) ? json["data"]["hanging"] : []),
        avgPercent: (_avgTotal != 0.toDouble())
            ? (_avgTotal / _avgAttempted * 100).round()
            : 0,
        percentScored: _percentScored);
  }

  static Team updateTeam(Team team,
      {String strengths, String flaws, String strategies}) {
    return Team(
      teamNumber: team.teamNumber,
      teamName: team.teamName,
      eventKey: team.eventKey,
      strengths: strengths ?? team.strengths,
      flaws: flaws ?? team.flaws,
      strategies: strategies ?? team.strategies,
      opr: team.opr,
      elo: team.elo,
      avgLow: team.avgLow,
      avgOuter: team.avgOuter,
      avgInner: team.avgInner,
      avgTotal: team.avgTotal,
      avgAttempted: team.avgAttempted,
      avgPercent: team.avgPercent,
      lowScored: team.lowScored,
      outerScored: team.outerScored,
      innerScored: team.innerScored,
      totalScored: team.totalScored,
      totalAttempted: team.totalAttempted,
      percentScored: team.percentScored,
      avgPen: team.avgPen,
      avgHang: team.avgHang,
      penalties: team.penalties,
      hanging: team.hanging,
    );
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
        return elo;
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

  @override
  List<Object> get props => [
        teamNumber,
        teamName,
        eventKey,
        strengths,
        flaws,
        strategies,
        opr,
        elo,
        avgLow,
        avgOuter,
        avgInner,
        avgTotal,
        avgAttempted,
        avgPercent,
        lowScored,
        outerScored,
        innerScored,
        totalScored,
        totalAttempted,
        percentScored,
        avgPen,
        avgHang,
        penalties,
        hanging
      ];
}
