import 'package:flutter/material.dart';
import 'package:frc_scouting/main.dart';
import 'package:frc_scouting/models/models.dart';
import 'package:frc_scouting/widgets/scoutingform/ScoutingView.dart';
import 'package:http/http.dart' as http;

// Map<String, dynamic> responseJson;

// class MatchView extends StatelessWidget {
//   final String eventKey;
//   const MatchView({Key key, @required this.eventKey}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Future<http.Response> _matches = http.get("$baseUrl/matches/$eventKey");
//     return FutureBuilder(
//         future: _matches,
//         builder: (BuildContext context, AsyncSnapshot<http.Response> response) {
//           if (response.hasData && response.data.body != "[]") {
//             return MatchListView(
//                 responseJson: jsonDecode(response.data.body),
//                 eventKey: eventKey);
//           } else if (response.hasData && response.data.body == "[]") {
//             return MatchReqView(eventKey: eventKey);
//           } else if (response.hasError) {
//             print("response has an error: " + response.error.toString());
//             return Scaffold();
//           } else {
//             print("error: no data");
//             return CircularProgressIndicator();
//           }
//         });
//   }
// }

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
            Navigator.pop(context);
          }),
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
                      "Qual " +
                          matchNumber(matches[index].matchNumber),
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
                                    eventKey: eventKey),
                                TeamButton(
                                    teamNumber: matches[index].red2,
                                    matchId: matches[index].id,
                                    eventKey: eventKey),
                                TeamButton(
                                    teamNumber: matches[index].red3,
                                    matchId: matches[index].id,
                                    eventKey: eventKey)
                              ],
                            )),
                        Container(
                            color: Colors.blueAccent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                TeamButton(
                                    teamNumber: matches[index].blue1,
                                    matchId: matches[index].id,
                                    eventKey: eventKey),
                                TeamButton(
                                    teamNumber: matches[index].blue2,
                                    matchId: matches[index].id,
                                    eventKey: eventKey),
                                TeamButton(
                                    teamNumber: matches[index].blue3,
                                    matchId: matches[index].id,
                                    eventKey: eventKey)
                              ],
                            ))
                      ],
                    )
                  ]));
        });
  }
}

class TeamButton extends StatelessWidget {
  final int teamNumber;
  final int matchId;
  final String eventKey;

  const TeamButton(
      {Key key,
      @required this.teamNumber,
      @required this.matchId,
      @required this.eventKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(teamNumber.toString()),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return ScoutingView(
              teamNumber: teamNumber,
              matchId: matchId,
              eventKey: eventKey);
        }));
      },
    );
  }
}

String matchNumber(int number) =>
    (number < 10) ? "0" + number.toString() : number.toString();
