import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frc_scouting/blocs/bottom_navigation_bloc.dart';
import 'package:frc_scouting/blocs/bottom_navigation_event.dart';
import 'package:frc_scouting/blocs/bottom_navigation_state.dart';
import 'package:frc_scouting/repositories/match_api_client.dart';
import 'package:frc_scouting/repositories/repositories.dart';
import 'package:frc_scouting/repositories/team_api_client.dart';
import 'package:frc_scouting/ui/pages/match_page.dart';
import 'package:frc_scouting/ui/pages/team_list_page.dart';
import 'package:http/http.dart' as http;

class EventPages extends StatelessWidget {
  final String eventKey;
  final String eventName;
  EventPages({Key key, @required this.eventKey, @required this.eventName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavigationBloc(
        matchRepository: MatchRepository(
            matchApiClient: MatchApiClient(httpClient: http.Client())),
        teamRepository: TeamRepository(
            teamApiClient: TeamApiClient(httpClient: http.Client())),
        blueAllianceId: eventKey,
      ),
      child: Scaffold(
          appBar: AppBar(
            title: Text(eventName),
            // actions: [
            //   _index == 0
            //       ? Container()
            //       : FlatButton(
            //           child: Icon(Icons.refresh),
            //           onPressed: () {
            //             http.put("$baseUrl/updateteams/$eventKey");
            //             Navigator.pop(context);
            //           },
            //         )
            // ],
          ),
          body: Center(
            child: BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
                builder: (context, state) {
              if (state is BottomNavigationInitial) {
                return Container();
              }
              if (state is PageLoading) {
                return CircularProgressIndicator();
              }
              if (state is MatchPageLoaded) {
                return MatchListPage(
                    eventKey: eventKey, matches: state.matches);
              }
              if (state is MatchPageEmpty) {
                return MatchReqPage(eventKey: eventKey);
              }
              if (state is TeamPageLoaded) {
                return TeamListPage(teams: state.teams);
              }
              if (state is TeamPageEmpty) {
                return TeamReqPage(
                  eventKey: eventKey,
                );
              }
              if (state is PageLoadError) {
                return Text(
                  "Something went wrong!",
                  style: TextStyle(color: Colors.red),
                );
              } else {
                return Container();
              }
            }),
          ),
          bottomNavigationBar: Builder(builder: (context) {
            return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
                builder: (context, state) {
              return BottomNavigationBar(
                  backgroundColor: Theme.of(context).bottomAppBarColor,
                  currentIndex: BlocProvider.of<BottomNavigationBloc>(context)
                      .currentIndex,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: Icon(Icons.trending_up), title: Text("Matches")),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.people), title: Text("Teams")),
                  ],
                  onTap: (newValue) {
                    BlocProvider.of<BottomNavigationBloc>(context)
                        .add(PageSwitched(index: newValue));
                  });
            });
          })),
    );
  }
}
