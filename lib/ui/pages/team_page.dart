import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frc_scouting/main.dart';
import 'package:frc_scouting/models/team.dart';
import 'package:frc_scouting/widgets/TeamChartView.dart';
import 'package:http/http.dart' as http;

class TeamLoader extends StatelessWidget {
  final int teamNumber;
  final String eventKey;
  const TeamLoader({Key key, @required this.teamNumber, @required this.eventKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<http.Response> _teamData =
        http.get("$baseUrl/team/$teamNumber/$eventKey");
    return FutureBuilder(
        future: _teamData,
        builder: (BuildContext context, AsyncSnapshot<http.Response> response) {
          if (response.hasData && response.data.body != "[]") {
            return TeamPage(
                team: Team.fromJson(jsonDecode(response.data.body)));
          } else if (response.hasError) {
            print("response has an error: ${response.error}");
            return Container();
          } else {
            print("error: no data");
            return Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          }
        });
  }
}

class TeamPage extends StatelessWidget {
  final Team team;
  const TeamPage({Key key, @required this.team}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Team updatedTeam = team;

    return Scaffold(
      appBar: AppBar(
        title: Text("Team #${team.teamNumber}"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("OPR", style: Theme.of(context).textTheme.subtitle1),
                  Text(team.opr.toString(),
                      style: Theme.of(context).textTheme.subtitle1)
                ],
              ),
              Divider(
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Elo", style: Theme.of(context).textTheme.subtitle1),
                  Text(team.elo.toString(),
                      style: Theme.of(context).textTheme.subtitle1),
                ],
              ),
              RaisedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                          "Percentage of matches with hanging: ${team.avgHang}%",
                          style: Theme.of(context).textTheme.subtitle1),
                    ),
                    Icon(Icons.arrow_forward)
                  ],
                ),
                onPressed: () {
                  Navigator.push((context),
                      MaterialPageRoute(builder: (context) {
                    return TeamChartView(
                        chartData: team.hanging,
                        title: "Hanging from team #${team.teamNumber}");
                  }));
                },
              ),
              RaisedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text("Average penalites per match: ${team.avgPen}",
                          style: Theme.of(context).textTheme.subtitle1),
                    ),
                    Icon(Icons.arrow_forward)
                  ],
                ),
                onPressed: () {
                  Navigator.push((context),
                      MaterialPageRoute(builder: (context) {
                    return TeamChartView(
                        chartData: team.penalties,
                        title: "Penalties from team #${team.teamNumber}");
                  }));
                },
              ),
              RaisedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text("Average Percent Scored: ${team.avgPercent}%",
                          style: Theme.of(context).textTheme.subtitle1),
                    ),
                    Icon(Icons.arrow_forward)
                  ],
                ),
                onPressed: () {
                  Navigator.push((context),
                      MaterialPageRoute(builder: (context) {
                    return TeamChartView(
                        chartData: team.percentScored,
                        title: "Percent scored from team #${team.teamNumber}");
                  }));
                },
              ),
              RaisedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text("Average Low Scored: ${team.avgLow}",
                          style: Theme.of(context).textTheme.subtitle1),
                    ),
                    Icon(Icons.arrow_forward)
                  ],
                ),
                onPressed: () {
                  Navigator.push((context),
                      MaterialPageRoute(builder: (context) {
                    return TeamChartView(
                        chartData: team.lowScored,
                        title: "Lower scoring from team #${team.teamNumber}");
                  }));
                },
              ),
              RaisedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text("Average Outer Scored: ${team.avgOuter}",
                          style: Theme.of(context).textTheme.subtitle1),
                    ),
                    Icon(Icons.arrow_forward)
                  ],
                ),
                onPressed: () {
                  Navigator.push((context),
                      MaterialPageRoute(builder: (context) {
                    return TeamChartView(
                        chartData: team.outerScored,
                        title: "Outer scoring from team #${team.teamNumber}");
                  }));
                },
              ),
              RaisedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text("Average Inner Scored: ${team.avgInner}",
                          style: Theme.of(context).textTheme.subtitle1),
                    ),
                    Icon(Icons.arrow_forward)
                  ],
                ),
                onPressed: () {
                  Navigator.push((context),
                      MaterialPageRoute(builder: (context) {
                    return TeamChartView(
                        chartData: team.innerScored,
                        title: "Inner scoring from team #${team.teamNumber}");
                  }));
                },
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                maxLength: 250,
                maxLengthEnforced: true,
                autocorrect: true,
                controller: TextEditingController(text: team.strengths),
                decoration: InputDecoration(
                  labelText: "Strengths",
                ),
                onChanged: (newValue) => updatedTeam =
                    Team.updateTeam(updatedTeam, strengths: newValue),
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                maxLength: 250,
                maxLengthEnforced: true,
                autocorrect: true,
                controller: TextEditingController(text: team.flaws),
                decoration: InputDecoration(
                  labelText: "Weaknesses",
                ),
                onChanged: (newValue) =>
                    updatedTeam = Team.updateTeam(updatedTeam, flaws: newValue),
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                maxLength: 250,
                maxLengthEnforced: true,
                autocorrect: true,
                controller: TextEditingController(text: team.strategies),
                decoration: InputDecoration(
                  labelText: "Strategies",
                ),
                onChanged: (newValue) => updatedTeam =
                    Team.updateTeam(updatedTeam, strategies: newValue),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          http.post(
              "$baseUrl/team/${updatedTeam.teamNumber}/${updatedTeam.eventKey}",
              body: jsonEncode(updatedTeam.toJson()),
              headers: {"Content-Type": "application/json"});
          Navigator.pop(context, true);
        },
      ),
    );
  }
}
