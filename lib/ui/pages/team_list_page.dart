import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frc_scouting/blocs/blocs.dart';
import 'package:frc_scouting/main.dart';
import 'package:frc_scouting/models/models.dart';
import 'package:frc_scouting/ui/dialogs/sort_team_dialog.dart';
import 'package:frc_scouting/ui/pages/team_page.dart';
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

class TeamListPage extends StatelessWidget {
  final List<Team> teams;
  final int sortMethod;
  final bool ascending;

  const TeamListPage({
    Key key,
    @required this.teams,
    @required this.sortMethod,
    @required this.ascending,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: teams.length + 1,
      separatorBuilder: (context, index) => Divider(
        thickness: 1,
      ),
      itemBuilder: (context, index) {
        if (index == 0) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Team",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Row(children: [
                    IconButton(
                        icon: Icon(ascending
                            ? Icons.arrow_upward
                            : Icons.arrow_downward),
                        onPressed: () {
                          BlocProvider.of<BottomNavigationBloc>(context).add(
                              SortChanged(teams,
                                  sortMethod: sortMethod,
                                  ascending: !ascending));
                        }),
                    IconButton(
                        icon: Icon(Icons.sort),
                        onPressed: () {
                          showDialog(
                              context: (context),
                              child: SortTeamDialog(
                                sortMethod: sortMethod,
                                ascending: ascending,
                              )).then((value) {
                            if (value != null) {
                              BlocProvider.of<BottomNavigationBloc>(context)
                                  .add(SortChanged(teams,
                                      sortMethod: value["sortMethod"],
                                      ascending: value["ascending"]));
                            }
                          });
                        }),
                  ]),
                ],
              ),
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
                        teams[index - 1].teamName,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        teams[index - 1].teamNumber.toString(),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                  (sortMethod != 0)
                      ? Text(teams[index - 1].getValue(sortMethod).toString())
                      : Container()
                ],
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute<void>(
                  // when clicked, it opens the match list and scouting for said item
                  builder: (BuildContext context) {
                    return TeamPage(team: teams[index - 1]);
                  },
                )).then((value) {
                  BlocProvider.of<BottomNavigationBloc>(context)
                      .add(PageSwitched(index: 1, sortMethod: sortMethod, ascending: ascending));
                });
              });
        }
      },
    );
  }
}
