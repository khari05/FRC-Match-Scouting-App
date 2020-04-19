class ScoutData {
  int teamNumber;
  int matchId;

  bool autonLine;
  bool autonLow;
  bool autonHigh;
  int totalAutonAttempted;
  int totalAutonScored;

  int lowScored;
  int outerScored;
  int innerScored;
  int attemptedLowScored;
  int attemptedHighScored;

  bool colorSpin;
  bool colorSelect;
  double hanging;

  ScoutData(dynamic json, this.teamNumber, this.matchId) {
    autonLine = (json["autonLine"] != null) ? json["autonLine"] : false;
    autonLow = (json["autonLow"] != null) ? json["autonLow"] : false;
    autonHigh = (json["autonHigh"] != null) ? json["autonHigh"] : false;
    totalAutonAttempted = (json["totalAutonAttempted"] != null) ? json["totalAutonAttempted"] : 0;
    totalAutonScored = (json["totalAutonScored"] != null) ? json["totalAutonScored"] : 0;
    lowScored = (json["lowScored"] != null) ? json["lowScored"] : 0;
    outerScored = (json["outerScored"] != null) ? json["outerScored"] : 0;
    innerScored = (json["innerScored"] != null) ? json["innerScored"] : 0;
    attemptedLowScored = (json["attemptedLowScored"] != null) ? json["attemptedLowScored"] : 0;
    attemptedHighScored = (json["attemptedHighScored"] != null) ? json["attemptedHighScored"] : 0;
    colorSpin = (json["colorSpin"] != null) ? json["colorSpin"] : false;
    colorSelect = (json["colorSelect"] != null) ? json["colorSelect"] : false;
    hanging = (json["hanging"] != null) ? json["hanging"] : 0;
  }
  toJsonString() {
    return {
      "data":{
        "autonLine":autonLine,
        "autonLow":autonLow,
        "autonHigh":autonHigh,
        "totalAutonAttempted":totalAutonAttempted,
        "totalAutonScored":totalAutonScored,
        "lowScored":lowScored,
        "outerScored":outerScored,
        "innerScored":innerScored,
        "attemptedLowScored":attemptedLowScored,
        "attemptedHighScored":attemptedHighScored,
        "colorSpin":colorSpin,
        "colorSelect":colorSelect,
        "hanging":hanging,
      }
    };
  }
}