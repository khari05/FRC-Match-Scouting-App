import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frc_scouting/main.dart';
import 'package:frc_scouting/models/team.dart';
import 'package:frc_scouting/widgets/TeamChartView.dart';
import 'package:http/http.dart' as http;

class TeamView extends StatelessWidget {
  final int teamNumber;
  final String eventKey;
  const TeamView({Key key, @required this.teamNumber, @required this.eventKey})
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

class TeamPage extends StatefulWidget {
  final Team team;
  const TeamPage({Key key, @required this.team}) : super(key: key);

  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Team #${widget.team.teamNumber}"),
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
                  Text(widget.team.opr.toString(),
                      style: Theme.of(context).textTheme.subtitle1)
                ],
              ),
              Divider(
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("DPR", style: Theme.of(context).textTheme.subtitle1),
                  Text(widget.team.dpr.toString(),
                      style: Theme.of(context).textTheme.subtitle1),
                ],
              ),
              RaisedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                          "Percentage of matches with hanging: ${widget.team.avgHang}",
                          style: Theme.of(context).textTheme.subtitle1),
                    ),
                    Icon(Icons.arrow_forward)
                  ],
                ),
                onPressed: () {
                  Navigator.push((context),
                      MaterialPageRoute(builder: (context) {
                    return TeamChartView(
                        chartData: widget.team.hanging,
                        title: "Hanging from team #${widget.team.teamNumber}");
                  }));
                },
              ),
              RaisedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                          "Average penalites per match: ${widget.team.avgPen}",
                          style: Theme.of(context).textTheme.subtitle1),
                    ),
                    Icon(Icons.arrow_forward)
                  ],
                ),
                onPressed: () {
                  Navigator.push((context),
                      MaterialPageRoute(builder: (context) {
                    return TeamChartView(
                        chartData: widget.team.penalties,
                        title:
                            "Penalties from team #${widget.team.teamNumber}");
                  }));
                },
              ),
              RaisedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text("Average Low Scored: ${widget.team.avgLow}",
                          style: Theme.of(context).textTheme.subtitle1),
                    ),
                    Icon(Icons.arrow_forward)
                  ],
                ),
                onPressed: () {
                  Navigator.push((context),
                      MaterialPageRoute(builder: (context) {
                    return TeamChartView(
                        chartData: widget.team.lowScored,
                        title:
                            "Lower scoring from team #${widget.team.teamNumber}");
                  }));
                },
              ),
              RaisedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                          "Average Outer Scored: ${widget.team.avgOuter}",
                          style: Theme.of(context).textTheme.subtitle1),
                    ),
                    Icon(Icons.arrow_forward)
                  ],
                ),
                onPressed: () {
                  Navigator.push((context),
                      MaterialPageRoute(builder: (context) {
                    return TeamChartView(
                        chartData: widget.team.outerScored,
                        title:
                            "Outer scoring from team #${widget.team.teamNumber}");
                  }));
                },
              ),
              RaisedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                          "Average Inner Scored: ${widget.team.avgInner}",
                          style: Theme.of(context).textTheme.subtitle1),
                    ),
                    Icon(Icons.arrow_forward)
                  ],
                ),
                onPressed: () {
                  Navigator.push((context),
                      MaterialPageRoute(builder: (context) {
                    return TeamChartView(
                        chartData: widget.team.innerScored,
                        title:
                            "Inner scoring from team #${widget.team.teamNumber}");
                  }));
                },
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                maxLength: 250,
                maxLengthEnforced: true,
                autocorrect: true,
                controller: TextEditingController(text: widget.team.strengths),
                decoration: InputDecoration(
                  labelText: "Strengths",
                ),
                onChanged: (newValue) => /* {widget.team.strengths = newValue}, */ null
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                maxLength: 250,
                maxLengthEnforced: true,
                autocorrect: true,
                controller: TextEditingController(text: widget.team.flaws),
                decoration: InputDecoration(
                  labelText: "Weaknesses",
                ),
                onChanged: (newValue) => /* {widget.team.flaws = newValue}, */ null
              ),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                maxLength: 250,
                maxLengthEnforced: true,
                autocorrect: true,
                controller: TextEditingController(text: widget.team.strategies),
                decoration: InputDecoration(
                  labelText: "Strategies",
                ),
                onChanged: (newValue) => /* {widget.team.flaws = newValue}, */ null
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
