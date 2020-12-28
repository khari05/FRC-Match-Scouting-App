import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:frc_scouting/models/models.dart';

abstract class ScoutingFormEvent extends Equatable {
  const ScoutingFormEvent();
}

class FormRequested extends ScoutingFormEvent {
  final int teamNumber;
  final int matchId;

  const FormRequested({@required this.teamNumber, @required this.matchId});

  @override
  List<Object> get props => [teamNumber, matchId];
}

class FormDataChanged extends ScoutingFormEvent {
  final String changedValue;
  final ScoutingData newForm;

  const FormDataChanged({this.changedValue, this.newForm});

  @override
  List<Object> get props => [changedValue, newForm];
}
