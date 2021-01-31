import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:frc_scouting/models/models.dart';

abstract class BottomNavigationEvent extends Equatable {
  const BottomNavigationEvent();
}

class PageSwitched extends BottomNavigationEvent {
  final int index;
  final int sortMethod;
  final bool ascending;

  const PageSwitched({@required this.index, this.sortMethod, this.ascending});

  @override
  List<Object> get props => [index];
}

class MatchViewToggled extends BottomNavigationEvent {
  final List<MatchObject> matches;
  final bool viewTeamName;

  MatchViewToggled({@required this.matches, @required this.viewTeamName});

  @override
  List<Object> get props => [matches, viewTeamName];
}

class SortChanged extends BottomNavigationEvent {
  final List<Team> teams;
  final int sortMethod;
  final bool ascending;

  const SortChanged(
    this.teams, {
    @required this.sortMethod,
    @required this.ascending,
  });

  @override
  List<Object> get props => [sortMethod, ascending, teams];
}
