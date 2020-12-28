import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';

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

  final List<FlSpot> lowScored;
  final List<FlSpot> outerScored;
  final List<FlSpot> innerScored;
  final List<FlSpot> totalScored;
  final List<FlSpot> totalAttempted;
  final List<FlSpot> percentScored;

  final double avgPen;
  final int avgHang;

  final List<FlSpot> penalties;
  final List<FlSpot> hanging;

  Team({
    this.teamNumber,
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
    this.hanging,
  });

  static Team fromJson(Map<String, dynamic> json) {
    final List<FlSpot> _emptyChart = [FlSpot(1, 0)];
    final double _avgTotal = (json["data"] != null)
        ? json["data"]["avgTotal"].toDouble()
        : 0.toDouble();
    final double _avgAttempted = (json["data"] != null)
        ? json["data"]["avgAttempted"].toDouble()
        : 0.toDouble();

    final List<FlSpot> _totalAttempted = (json["data"] != null)
        ? _parseChart(json["data"]["totalAttempted"])
        : _emptyChart;
    final List<FlSpot> _totalScored = (json["data"] != null)
        ? _parseChart(json["data"]["totalScored"])
        : _emptyChart;

    List<FlSpot> _percentScored = [];
    _totalAttempted.forEach((element) {
      _percentScored.add(
        FlSpot(
          element.x,
          element.y == 0
              ? 0
              : double.parse(((_totalScored
                              .firstWhere((FlSpot item) => item.x == element.x)
                              .y /
                          element.y) *
                      100)
                  .toStringAsFixed(2)),
        ),
      );
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
      avgOuter:
          (json["data"] != null) ? json["data"]["avgOuter"].toDouble() : 0,
      avgInner: (json["data"] != null)
          ? json["data"]["avgInner"].toDouble()
          : 0.toDouble(),
      avgTotal: _avgTotal,
      avgAttempted: _avgAttempted,
      lowScored: (json["data"] != null)
          ? _parseChart(json["data"]["lowScored"])
          : _emptyChart,
      outerScored: (json["data"] != null)
          ? _parseChart(json["data"]["outerScored"])
          : _emptyChart,
      innerScored: (json["data"] != null)
          ? _parseChart(json["data"]["innerScored"])
          : _emptyChart,
      totalScored: _totalScored,
      totalAttempted: _totalAttempted,
      avgPen: (json["data"] != null && json["data"]["avgPen"] != null)
          ? json["data"]["avgPen"].toDouble()
          : 0.toDouble(),
      avgHang: (json["data"] != null && json["data"]["avgHang"] != null)
          ? json["data"]["avgHang"].round()
          : 0,
      penalties: (json["data"] != null)
          ? _parseChart(json["data"]["penalties"])
          : _emptyChart,
      hanging: (json["data"] != null)
          ? _parseChart(json["data"]["hanging"])
          : _emptyChart,
      avgPercent: (_avgTotal != 0.toDouble())
          ? (_avgTotal / _avgAttempted * 100).round()
          : 0,
      percentScored: _percentScored,
    );
  }

  static List<FlSpot> _parseChart(List<dynamic> parsedJson) {
    List<FlSpot> data = [];
    parsedJson.forEach((element) {
      data.add(
        FlSpot(
          element["matchNumber"].toDouble(),
          element["data"].toDouble(),
        ),
      );
    });
    return data;
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
