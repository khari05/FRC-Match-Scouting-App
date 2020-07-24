import 'package:flutter/material.dart';

class ScoutingDataModel {
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

  int amountOfStucks;
  int amountOfPenalties;

  ScoutingDataModel({
    @required this.teamNumber,
    @required this.matchId,
  }) {
    autonLine = false;
    autonLow = false;
    autonHigh = false;
    totalAutonAttempted = 0;
    totalAutonScored = 0;

    lowScored = 0;
    outerScored = 0;
    innerScored = 0;

    attemptedLowScored = 0;
    attemptedHighScored = 0;

    colorSpin = false;
    colorSelect = false;

    amountOfStucks = 0;
    amountOfPenalties = 0;
  }

  ScoutingDataModel.fromJson({@required Map<String, dynamic> json, @required this.teamNumber, @required this.matchId}) {
    autonLine = (json["autonLine"] != null) ? json["autonLine"] : false;
    autonLow = (json["autonLow"] != null) ? json["autonLow"] : false;
    autonHigh = (json["autonHigh"] != null) ? json["autonHigh"] : false;
    totalAutonAttempted =
        (json["totalAutonAttempted"] != null) ? json["totalAutonAttempted"] : 0;
    totalAutonScored =
        (json["totalAutonScored"] != null) ? json["totalAutonScored"] : 0;
    lowScored = (json["lowScored"] != null) ? json["lowScored"] : 0;
    outerScored = (json["outerScored"] != null) ? json["outerScored"] : 0;
    innerScored = (json["innerScored"] != null) ? json["innerScored"] : 0;
    attemptedLowScored =
        (json["attemptedLowScored"] != null) ? json["attemptedLowScored"] : 0;
    attemptedHighScored =
        (json["attemptedHighScored"] != null) ? json["attemptedHighScored"] : 0;
    colorSpin = (json["colorSpin"] != null) ? json["colorSpin"] : false;
    colorSelect = (json["colorSelect"] != null) ? json["colorSelect"] : false;
    hanging = (json["hanging"] != null) ? json["hanging"].toDouble() : null;
    amountOfStucks =
        (json["amountOfStucks"] != null) ? json["amountOfStucks"] : 0;
    amountOfPenalties =
        (json["amountOfPenalties"] != null) ? json["amountOfPenalties"] : 0;
  }
  Map<String, dynamic> toJson() {
    return {
      "data": {
        "autonLine": autonLine,
        "autonLow": autonLow,
        "autonHigh": autonHigh,
        "totalAutonAttempted": totalAutonAttempted,
        "totalAutonScored": totalAutonScored,
        "lowScored": lowScored,
        "outerScored": outerScored,
        "innerScored": innerScored,
        "attemptedLowScored": attemptedLowScored,
        "attemptedHighScored": attemptedHighScored,
        "colorSpin": colorSpin,
        "colorSelect": colorSelect,
        "hanging": hanging,
        "amountOfStucks": amountOfStucks,
        "amountOfPenalties": amountOfPenalties,
        "totalScored": totalAutonScored + lowScored + outerScored + innerScored,
        "totalAttempted":
            totalAutonAttempted + attemptedLowScored + attemptedHighScored,
      }
    };
  }

  edit(String key, dynamic value) {
    switch (key) {
      case "autonLine":
        autonLine = value;
        break;
      case "autonLow":
        autonLow = value;
        break;
      case "autonHigh":
        autonHigh = value;
        break;
      case "totalAutonAttempted":
        totalAutonAttempted = value;
        break;
      case "totalAutonScored":
        totalAutonScored = value;
        break;
      case "lowScored":
        lowScored = value;
        break;
      case "outerScored":
        outerScored = value;
        break;
      case "innerScored":
        innerScored = value;
        break;
      case "attemptedLowScored":
        attemptedLowScored = value;
        break;
      case "attemptedHighScored":
        attemptedHighScored = value;
        break;
      case "colorSpin":
        colorSpin = value;
        break;
      case "colorSelect":
        colorSelect = value;
        break;
      case "hanging":
        hanging = value;
        break;
      case "amountOfStucks":
        amountOfStucks = value;
        break;
      case "amountOfPenalties":
        amountOfPenalties = value;
        break;
    }
  }

  view(String key) {
    switch (key) {
      case "autonLine":
        return autonLine;
        break;
      case "autonLow":
        return autonLow;
        break;
      case "autonHigh":
        return autonHigh;
        break;
      case "totalAutonAttempted":
        return totalAutonAttempted;
        break;
      case "totalAutonScored":
        return totalAutonScored;
        break;
      case "lowScored":
        return lowScored;
        break;
      case "outerScored":
        return outerScored;
        break;
      case "innerScored":
        return innerScored;
        break;
      case "attemptedLowScored":
        return attemptedLowScored;
        break;
      case "attemptedHighScored":
        return attemptedHighScored;
        break;
      case "colorSpin":
        return colorSpin;
        break;
      case "colorSelect":
        return colorSelect;
        break;
      case "hanging":
        return hanging;
        break;
      case "amountOfStucks":
        return amountOfStucks;
        break;
      case "amountOfPenalties":
        return amountOfPenalties;
        break;
    }
  }
}
