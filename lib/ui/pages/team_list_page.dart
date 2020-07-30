import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frc_scouting/blocs/blocs.dart';
import 'package:frc_scouting/main.dart';
import 'package:frc_scouting/models/models.dart';
import 'package:frc_scouting/widgets/TeamView.dart';
import 'package:http/http.dart' as http;

class TeamReqPage extends StatelessWidget {
  final String eventKey;

  const TeamReqPage({Key key, this.eventKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        child: Text("Pull Teams From TBA"),
        onPressed: () {
          http.put("$baseUrl/pullteams/$eventKey");
          BlocProvider.of<BottomNavigationBloc>(context)
              .add(PageSwitched(index: 1));
        });
  }
}

class TeamListPage extends StatefulWidget {
  final List<Team> teams;
  const TeamListPage({Key key, @required this.teams}) : super(key: key);

  @override
  _TeamListPageState createState() => _TeamListPageState();
}

class _TeamListPageState extends State<TeamListPage> {
  List<Team> _teams;
  int sortBy = 0;
  bool ascending = true;
  @override
  Widget build(BuildContext context) {
    _teams = widget.teams;
    TextStyle subtitleStyle = Theme.of(context).textTheme.subtitle2;

    if (ascending) {
      _teams.sort((a, b) => (a.getValue(sortBy).compareTo(b.getValue(sortBy))));
    } else {
      _teams.sort((a, b) => (b.getValue(sortBy).compareTo(a.getValue(sortBy))));
    }

    return ListView.separated(
      itemCount: _teams.length + 1,
      separatorBuilder: (context, index) => Divider(
        thickness: 1,
      ),
      itemBuilder: (context, index) {
        if (index == 0) {
          return Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "Team",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Sort By", style: subtitleStyle),
                    Padding(padding: EdgeInsets.all(4)),
                    DropdownButton(
                      value: sortBy,
                      items: [
                        DropdownMenuItem(
                            value: 0,
                            child: Text("Team Number", style: subtitleStyle)),
                        DropdownMenuItem(
                            value: 1,
                            child: Text("Team OPR", style: subtitleStyle)),
                        DropdownMenuItem(
                            value: 2,
                            child: Text("Team DPR", style: subtitleStyle)),
                        DropdownMenuItem(
                            value: 3,
                            child: Text("Average Low Scored",
                                style: subtitleStyle)),
                        DropdownMenuItem(
                            value: 4,
                            child: Text("Average Outer Scored",
                                style: subtitleStyle)),
                        DropdownMenuItem(
                            value: 5,
                            child: Text("Average Inner scored",
                                style: subtitleStyle)),
                        DropdownMenuItem(
                            value: 6,
                            child: Text("Average Penalites",
                                style: subtitleStyle)),
                        DropdownMenuItem(
                            value: 7,
                            child: Text("Hanging Percentage",
                                style: subtitleStyle)),
                      ],
                      onChanged: (value) {
                        setState(() {
                          sortBy = value;
                          if (value == 0 || value == 6) {
                            ascending = true;
                          } else {
                            ascending = false;
                          }
                        });
                      },
                    ),
                    FlatButton.icon(
                      icon: Icon(ascending
                          ? Icons.arrow_upward
                          : Icons.arrow_downward),
                      label: Container(),
                      onPressed: () => setState(() => ascending = !ascending),
                    )
                  ],
                ),
              ],
            ),
          );
        } else {
          return FlatButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _teams[index - 1].teamName,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        _teams[index - 1].teamNumber.toString(),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                  (sortBy != 0)
                      ? Text(_teams[index - 1].getValue(sortBy).toString())
                      : Container()
                ],
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute<void>(
                  // when clicked, it opens the match list and scouting for said item
                  builder: (BuildContext context) {
                    return TeamPage(team: _teams[index - 1]);
                  },
                ));
              });
        }
      },
    );
  }
}
