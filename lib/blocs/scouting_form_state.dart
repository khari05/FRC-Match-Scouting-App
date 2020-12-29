import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:frc_scouting/models/models.dart';

abstract class ScoutingFormState extends Equatable {
  const ScoutingFormState();

  @override
  List<Object> get props => [];
}

class ScoutingFormInitial extends ScoutingFormState {}

class ScoutingFormLoadInProgress extends ScoutingFormState {}

class ScoutingFormLoadSuccess extends ScoutingFormState {
  final ScoutingData form;

  const ScoutingFormLoadSuccess({@required this.form}) : assert(form != null);

  @override
  List<Object> get props => [form];
}

class ScoutingFormLoadError extends ScoutingFormState {}
