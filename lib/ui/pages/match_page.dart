import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frc_scouting/blocs/blocs.dart';
import 'package:frc_scouting/main.dart';
import 'package:frc_scouting/models/models.dart';
import 'package:frc_scouting/ui/pages/scouting_form_page.dart';
import 'package:http/http.dart' as http;

class MatchReqPage extends StatelessWidget {
  final String eventKey;

  const MatchReqPage({Key key, @required this.eventKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text("Pull Matches From TBA"),
        onPressed: () {
          http.put("$baseUrl/pullmatches/$eventKey");
          BlocProvider.of<BottomNavigationBloc>(context)
              .add(PageSwitched(index: 0));
        },
      ),
    );
  }
}

class MatchListPage extends StatelessWidget {
  final String eventKey;
  final List<MatchObject> matches;

  const MatchListPage(
      {Key key, @required this.eventKey, @required this.matches})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: matches.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Qual " + matchNumber(matches[index].matchNumber),
                  textAlign: TextAlign.center,
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        TeamButton(
                          teamNumber: matches[index].red1,
                          teamName: matches[index].redName1,
                          matchId: matches[index].id,
                          eventKey: eventKey,
                        ),
                        TeamButton(
                          teamNumber: matches[index].red2,
                          teamName: matches[index].redName2,
                          matchId: matches[index].id,
                          eventKey: eventKey,
                        ),
                        TeamButton(
                          teamNumber: matches[index].red3,
                          teamName: matches[index].redName3,
                          matchId: matches[index].id,
                          eventKey: eventKey,
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    color: Colors.blueAccent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TeamButton(
                          teamNumber: matches[index].blue1,
                          teamName: matches[index].blueName1,
                          matchId: matches[index].id,
                          eventKey: eventKey,
                        ),
                        TeamButton(
                          teamNumber: matches[index].blue2,
                          teamName: matches[index].blueName2,
                          matchId: matches[index].id,
                          eventKey: eventKey,
                        ),
                        TeamButton(
                          teamNumber: matches[index].blue3,
                          teamName: matches[index].blueName3,
                          matchId: matches[index].id,
                          eventKey: eventKey,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class TeamButton extends StatelessWidget {
  final int teamNumber;
  final String teamName;
  final int matchId;
  final String eventKey;

  const TeamButton({
    Key key,
    @required this.teamNumber,
    @required this.matchId,
    @required this.eventKey,
    @required this.teamName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        if (state is MatchPageLoaded) {
          return Tooltip(
            message: state.viewTeamName ? teamName : teamNumber.toString(),
            child: FlatButton(
              child: Text(
                state.viewTeamName
                    ? shortenedTeamName(context, teamName)
                    : teamNumber.toString(),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return ScoutingFormPage(
                    teamNumber: teamNumber,
                    matchId: matchId,
                    eventKey: eventKey,
                  );
                }));
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

String matchNumber(int number) {
  return number < 10 ? "0" + number.toString() : number.toString();
}

String shortenedTeamName(BuildContext context, String name) {
  return name.trim().length > nameLength(context)
      ? name.trim().substring(0, nameLength(context) - 1)
      : name.trim();
}

int nameLength(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  if (screenWidth < 400) {
    return 8;
  } else if (screenWidth < 600) {
    return 9;
  } else {
    return 25;
  }
}
