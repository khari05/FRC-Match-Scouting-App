import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:frc_scouting/models/models.dart';
import 'package:frc_scouting/models/team.dart';

abstract class BottomNavigationState extends Equatable {
  const BottomNavigationState();

  @override
  List<Object> get props => [];
}

class BottomNavigationInitial extends BottomNavigationState {}

class CurrentIndexChanged extends BottomNavigationState {
  final int currentIndex;

  CurrentIndexChanged({@required this.currentIndex})
      : assert(currentIndex != null);

  @override
  List<Object> get props => [currentIndex];
}

class PageLoading extends BottomNavigationState {}

class MatchPageLoaded extends BottomNavigationState {
  final List<MatchObject> matches;
  final bool viewTeamName;

  MatchPageLoaded({@required this.matches, @required this.viewTeamName})
      : assert(matches != null);

  @override
  List<Object> get props => [matches, viewTeamName];
}

class MatchPageEmpty extends BottomNavigationState {}

class TeamPageLoaded extends BottomNavigationState {
  final List<Team> teams;
  final int sortMethod;
  final bool ascending;

  TeamPageLoaded({
    @required this.teams,
    @required this.sortMethod,
    @required this.ascending,
  }) : assert(teams != null);
}

class TeamPageEmpty extends BottomNavigationState {}

class PageLoadError extends BottomNavigationState {}
