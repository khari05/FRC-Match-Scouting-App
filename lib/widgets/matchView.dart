import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frc_scouting/main.dart';
import 'package:frc_scouting/widgets/scoutingform/ScoutingView.dart';
import 'package:http/http.dart' as http;

dynamic responseJson;

class MatchView extends StatelessWidget {
  final String eventKey;
  const MatchView({Key key, @required this.eventKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<http.Response> _matches = http.get("$url/matches/$eventKey");
    return FutureBuilder(
        future: _matches,
        builder: (BuildContext context, AsyncSnapshot<http.Response> response) {
          if (response.hasData && response.data.body != "[]") {
            return MatchListView(
                responseJson: jsonDecode(response.data.body),
                eventKey: eventKey);
          } else if (response.hasData && response.data.body == "[]") {
            return MatchReqView(eventKey: eventKey);
          } else if (response.hasError) {
            print("response has an error: " + response.error.toString());
            return Scaffold();
          } else {
            print("error: no data");
            return CircularProgressIndicator();
          }
        });
  }
}

class MatchReqView extends StatelessWidget {
  final String eventKey;

  const MatchReqView({Key key, @required this.eventKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
          child: Text("Pull Matches From TBA"),
          onPressed: () {
            http.put("$url/pullmatches/$eventKey");
            Navigator.pop(context);
          }),
    );
  }
}

class MatchListView extends StatelessWidget {
  final String eventKey;
  final List responseJson;

  const MatchListView(
      {Key key, @required this.eventKey, @required this.responseJson})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: responseJson.length,
        itemBuilder: (context, index) {
          return Container(
              padding: EdgeInsets.all(5),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Qual " +
                          matchNumber(responseJson[index]["match_number"]),
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
                                    index: index,
                                    responseJson: responseJson,
                                    station: "red1",
                                    eventKey: eventKey),
                                TeamButton(
                                    index: index,
                                    responseJson: responseJson,
                                    station: "red2",
                                    eventKey: eventKey),
                                TeamButton(
                                    index: index,
                                    responseJson: responseJson,
                                    station: "red3",
                                    eventKey: eventKey)
                              ],
                            )),
                        Container(
                            color: Colors.blueAccent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                TeamButton(
                                    index: index,
                                    responseJson: responseJson,
                                    station: "blue1",
                                    eventKey: eventKey),
                                TeamButton(
                                    index: index,
                                    responseJson: responseJson,
                                    station: "blue2",
                                    eventKey: eventKey),
                                TeamButton(
                                    index: index,
                                    responseJson: responseJson,
                                    station: "blue3",
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
  final int index;
  final dynamic responseJson;
  final String station;
  final String eventKey;

  const TeamButton(
      {Key key,
      @required this.index,
      @required this.responseJson,
      @required this.station,
      @required this.eventKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(responseJson[index][station].toString()),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return ScoutingView(
              teamNumber: responseJson[index][station],
              matchId: responseJson[index]["id"],
              eventKey: eventKey);
        }));
      },
    );
  }
}

String matchNumber(int number) =>
    (number < 10) ? "0" + number.toString() : number.toString();
