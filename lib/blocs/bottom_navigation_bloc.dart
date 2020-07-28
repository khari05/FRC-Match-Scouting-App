import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frc_scouting/blocs/bottom_navigation_event.dart';
import 'package:frc_scouting/blocs/bottom_navigation_state.dart';
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
            yield TeamPageLoaded(teams: teams);
          }
        }
      } catch (err) {
        yield PageLoadError();
      }
    }
  }
}
