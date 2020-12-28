import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ScoutingData extends Equatable {
  final int teamNumber;
  final int matchId;

  final bool autonLine;
  final bool autonLow;
  final bool autonHigh;
  final int totalAutonAttempted;
  final int totalAutonScored;

  final int lowScored;
  final int outerScored;
  final int innerScored;
  final int attemptedLowScored;
  final int attemptedHighScored;

  final bool colorSpin;
  final bool colorSelect;
  final double hanging;

  final int amountOfStucks;
  final int amountOfPenalties;

  ScoutingData({
    @required this.teamNumber,
    @required this.matchId,
    this.autonLine = false,
    this.autonLow = false,
    this.autonHigh = false,
    this.totalAutonAttempted = 0,
    this.totalAutonScored = 0,
    this.lowScored = 0,
    this.outerScored = 0,
    this.innerScored = 0,
    this.attemptedLowScored = 0,
    this.attemptedHighScored = 0,
    this.colorSpin = false,
    this.colorSelect = false,
    this.hanging,
    this.amountOfStucks = 0,
    this.amountOfPenalties = 0,
  });

  static ScoutingData fromJson({
    @required Map<String, dynamic> json,
    @required teamNumber,
    @required matchId,
  }) {
    return ScoutingData(
      teamNumber: teamNumber,
      matchId: matchId,
      autonLine: json["autonLine"] ?? false,
      autonLow: json["autonLow"] ?? false,
      autonHigh: json["autonHigh"] ?? false,
      totalAutonAttempted: json["totalAutonAttempted"] ?? 0,
      totalAutonScored: json["totalAutonScored"] ?? 0,
      lowScored: json["lowScored"] ?? 0,
      outerScored: json["outerScored"] ?? 0,
      innerScored: json["innerScored"] ?? 0,
      attemptedLowScored: json["attemptedLowScored"] ?? 0,
      attemptedHighScored: json["attemptedHighScored"] ?? 0,
      colorSpin: json["colorSpin"] ?? false,
      colorSelect: json["colorSelect"] ?? false,
      hanging: json["hanging"].toDouble() ?? null,
      amountOfStucks: json["amountOfStucks"] ?? 0,
      amountOfPenalties: json["amountOfPenalties"] ?? 0,
    );
  }

  static ScoutingData edit(ScoutingData form, String key, dynamic value) {
    return ScoutingData(
      teamNumber: form.teamNumber,
      matchId: form.matchId,
      autonLine: (key == "autonLine") ? value : form.autonLine,
      autonLow: (key == "autonLow") ? value : form.autonLow,
      autonHigh: (key == "autonHigh") ? value : form.autonHigh,
      totalAutonAttempted:
          (key == "totalAutonAttempted") ? value : form.totalAutonAttempted,
      totalAutonScored:
          (key == "totalAutonScored") ? value : form.totalAutonScored,
      lowScored: (key == "lowScored") ? value : form.lowScored,
      outerScored: (key == "outerScored") ? value : form.outerScored,
      innerScored: (key == "innerScored") ? value : form.innerScored,
      attemptedLowScored:
          (key == "attemptedLowScored") ? value : form.attemptedLowScored,
      attemptedHighScored:
          (key == "attemptedHighScored") ? value : form.attemptedHighScored,
      colorSpin: (key == "colorSpin") ? value : form.colorSpin,
      colorSelect: (key == "colorSelect") ? value : form.colorSelect,
      hanging: (key == "hanging") ? value.toDouble() : form.hanging,
      amountOfStucks: (key == "amountOfStucks") ? value : form.amountOfStucks,
      amountOfPenalties:
          (key == "amountOfPenalties") ? value : form.amountOfPenalties,
    );
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
        "hanging": hanging != null ? hanging : 0,
        "amountOfStucks": amountOfStucks,
        "amountOfPenalties": amountOfPenalties,
        "totalScored": totalAutonScored + lowScored + outerScored + innerScored,
        "totalAttempted":
            totalAutonAttempted + attemptedLowScored + attemptedHighScored,
      }
    };
  }

  @override
  List<Object> get props => [
        teamNumber,
        matchId,
        autonLine,
        autonLow,
        autonHigh,
        totalAutonAttempted,
        totalAutonScored,
        lowScored,
        outerScored,
        innerScored,
        attemptedLowScored,
        attemptedHighScored,
        colorSpin,
        colorSelect,
        hanging,
        amountOfStucks,
        amountOfPenalties,
      ];
}
