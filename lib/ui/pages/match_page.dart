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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "Qual " + matchNumber(matches[index].matchNumber),
                textAlign: TextAlign.center,
              ),
              Column(
                children: <Widget>[
                  Container(
                    color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        TeamButton(
                          teamNumber: matches[index].red1,
                          matchId: matches[index].id,
                          eventKey: eventKey,
                        ),
                        TeamButton(
                          teamNumber: matches[index].red2,
                          matchId: matches[index].id,
                          eventKey: eventKey,
                        ),
                        TeamButton(
                          teamNumber: matches[index].red3,
                          matchId: matches[index].id,
                          eventKey: eventKey,
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.blueAccent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        TeamButton(
                          teamNumber: matches[index].blue1,
                          matchId: matches[index].id,
                          eventKey: eventKey,
                        ),
                        TeamButton(
                          teamNumber: matches[index].blue2,
                          matchId: matches[index].id,
                          eventKey: eventKey,
                        ),
                        TeamButton(
                          teamNumber: matches[index].blue3,
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
  final int matchId;
  final String eventKey;

  const TeamButton({
    Key key,
    @required this.teamNumber,
    @required this.matchId,
    @required this.eventKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(teamNumber.toString()),
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
    );
  }
}

String matchNumber(int number) =>
    (number < 10) ? "0" + number.toString() : number.toString();
