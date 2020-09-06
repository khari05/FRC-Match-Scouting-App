import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frc_scouting/blocs/blocs.dart';
import 'package:frc_scouting/models/models.dart';
import 'package:frc_scouting/repositories/repositories.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  final MatchRepository matchRepository;
  final TeamRepository teamRepository;
  final String blueAllianceId;
  int currentIndex = 0;

  BottomNavigationBloc(
      {@required this.matchRepository,
      @required this.teamRepository,
      @required this.blueAllianceId})
      : assert(matchRepository != null),
        assert(teamRepository != null),
        super(BottomNavigationInitial());

  @override
  Stream<BottomNavigationState> mapEventToState(
      BottomNavigationEvent event) async* {
    if (event is PageSwitched) {
      currentIndex = event.index;
      yield CurrentIndexChanged(currentIndex: this.currentIndex);
      yield PageLoading();

      try {
        if (currentIndex == 0) {
          List<MatchObject> matches =
              await matchRepository.getMatches(blueAllianceId);
          if (matches.length == 0) {
            yield MatchPageEmpty();
          } else {
            yield MatchPageLoaded(matches: matches);
          }
        }
        if (currentIndex == 1) {
          List<Team> teams = await teamRepository.getTeams(blueAllianceId);
          if (teams.length == 0) {
            yield TeamPageEmpty();
          } else {
            yield TeamPageLoaded(teams: teams, ascending: event.ascending ?? true, sortMethod: event.sortMethod ?? 0);
          }
        }
      } catch (err) {
        yield PageLoadError();
        print(err);
      }
    }
    if (event is SortChanged) {
      List<Team> teams = event.teams;
      final int sortMethod = event.sortMethod;

      yield PageLoading();

      if (event.ascending) {
        teams.sort((a, b) =>
            (a.getValue(sortMethod).compareTo(b.getValue(sortMethod))));
      } else {
        teams.sort((a, b) =>
            (b.getValue(sortMethod).compareTo(a.getValue(sortMethod))));
      }
      yield TeamPageLoaded(
          teams: teams, sortMethod: sortMethod, ascending: event.ascending);
    }
  }
}
