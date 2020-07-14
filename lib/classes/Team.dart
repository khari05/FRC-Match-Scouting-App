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

  List<int> lowScored;
  List<int> outerScored;
  List<int> innerScored;

  double avgPen;
  double avgHang;

  List<int> penalties;
  List<int> hanging;

  Team(dynamic json) {
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

    avgLow = (json["data"] != null && json["data"]["avgLow"] != null)
        ? json["data"]["avgLow"].toDouble()
        : 0.toDouble();
    avgOuter = (json["data"] != null && json["data"]["avgOuter"] != null)
        ? json["data"]["avgOuter"].toDouble()
        : 0.toDouble();
    avgInner = (json["data"] != null && json["data"]["avgInner"] != null)
        ? json["data"]["avgInner"].toDouble()
        : 0.toDouble();

    lowScored = (json["data"] != null && json["data"]["avgLow"] != null)
        ? json["data"]["lowScored"]
        : [];
    outerScored = (json["data"] != null && json["data"]["avgOuter"] != null)
        ? json["data"]["outerScored"]
        : [];
    innerScored = (json["data"] != null && json["data"]["avgInner"] != null)
        ? json["data"]["innerScored"]
        : [];

    avgPen = (json["data"] != null && json["data"]["avgPen"] != null)
        ? json["data"]["avgPen"].toDouble()
        : 0.toDouble();
    avgHang = (json["data"] != null && json["data"]["avgHang"] != null)
        ? json["data"]["avgHang"].toDouble()
        : 0.toDouble();

    penalties = (json["data"] != null && json["data"]["penalites"] != null)
        ? json["data"]["penalites"]
        : [];
    hanging = (json["data"] != null && json["data"]["hanging"] != null)
        ? json["data"]["hanging"]
        : [];
  }

  toJsonString() {
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
