import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frc_scouting/blocs/blocs.dart';
import 'package:frc_scouting/main.dart';
import 'package:frc_scouting/repositories/repositories.dart';
import 'package:frc_scouting/repositories/scouting_data_api_client.dart';
import 'package:frc_scouting/ui/pages/team_page.dart';
import 'package:frc_scouting/ui/widgets/checkbox_card.dart';
import 'package:frc_scouting/ui/widgets/hanging_dropdown_card.dart';
import 'package:frc_scouting/ui/widgets/number_card.dart';
import 'package:http/http.dart' as http;

class ScoutingFormPage extends StatelessWidget {
  final int teamNumber;
  final int matchId;
  final String eventKey;

  const ScoutingFormPage(
      {Key key,
      @required this.teamNumber,
      @required this.matchId,
      @required this.eventKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScoutingFormBloc>(
      create: (context) => ScoutingFormBloc(
        scoutingDataRepository: ScoutingDataRepository(
          scoutingDataApiClient:
              ScoutingDataApiClient(httpClient: http.Client()),
        ),
        teamNumber: teamNumber,
        matchId: matchId,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Scouting Team #$teamNumber"),
          actions: [
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return TeamLoader(
                        teamNumber: teamNumber,
                        eventKey: eventKey,
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
        body: Center(
          child: Builder(
            builder: (context) =>
                BlocBuilder<ScoutingFormBloc, ScoutingFormState>(
              builder: (context, state) {
                if (state is ScoutingFormInitial) {
                  BlocProvider.of<ScoutingFormBloc>(context).add(
                    FormRequested(teamNumber: teamNumber, matchId: matchId),
                  );
                }
                if (state is ScoutingFormLoadSuccess) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: <Widget>[
                        ExpansionTile(
                          title: Text("Defense"),
                          children: [
                            /** //TODO add in defense options
                       * did the team play defense
                       * did the team get any penalties while playing defense
                       * # of times they prevented the opposing team from scoring
                       **/
                          ],
                        ),
                        ExpansionTile(
                          title: Text(
                            "Autonomous",
                          ),
                          initiallyExpanded: false,
                          children: [
                            CheckboxCard(
                                state.form,
                                "autonLine",
                                state.form.autonLine,
                                "Does the team get off of the line?"),
                            CheckboxCard(
                                state.form,
                                "autonLow",
                                state.form.autonLow,
                                "Does the team score in the low goal?"),
                            CheckboxCard(
                                state.form,
                                "autonHigh",
                                state.form.autonHigh,
                                "Does the team score in the high goal?"),
                            NumberCard(
                                state.form,
                                "totalAutonScored",
                                state.form.totalAutonScored,
                                "Total balls scored during autonomous"),
                            NumberCard(
                                state.form,
                                "totalAutonAttempted",
                                state.form.totalAutonAttempted,
                                "Total balls attempted to be scored during autonomous"),
                          ],
                        ),
                        ExpansionTile(
                          title: Text(
                            "TeleOp",
                          ),
                          initiallyExpanded: false,
                          children: [
                            NumberCard(
                                state.form,
                                "lowScored",
                                state.form.lowScored,
                                "Total scored in the low goal"),
                            NumberCard(
                                state.form,
                                "outerScored",
                                state.form.outerScored,
                                "Total scored in the outer goal"),
                            NumberCard(
                                state.form,
                                "innerScored",
                                state.form.innerScored,
                                "Total scored in the inner goal"),
                            NumberCard(
                                state.form,
                                "attemptedLowScored",
                                state.form.attemptedLowScored,
                                "Total attempted to score in the low goal"),
                            NumberCard(
                                state.form,
                                "attemptedHighScored",
                                state.form.attemptedHighScored,
                                "Total attempted to score in the high goal"),
                          ],
                        ),
                        ExpansionTile(
                          title: Text(
                            "End Game",
                          ),
                          initiallyExpanded: false,
                          children: [
                            CheckboxCard(
                                state.form,
                                "colorSpin",
                                state.form.colorSpin,
                                "Does the team spin the Control Panel 3 times? (stage 2)"),
                            CheckboxCard(
                                state.form,
                                "colorSelect",
                                state.form.colorSelect,
                                "Does the team spin the Control Panel to a specific color? (stage 3)"),
                            HangDropdown(state.form),
                            NumberCard(
                                state.form,
                                "amountOfStucks",
                                state.form.amountOfStucks,
                                "Number of times the robot gets stuck"),
                            NumberCard(
                                state.form,
                                "amountOfPenalties",
                                state.form.amountOfPenalties,
                                "Number of penalties the team gets"),
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ),
        floatingActionButton: Builder(
          builder: (context) =>
              BlocBuilder<ScoutingFormBloc, ScoutingFormState>(
            builder: (context, state) {
              if (state is ScoutingFormLoadSuccess) {
                return FloatingActionButton(
                  child: Icon(Icons.save),
                  onPressed: () {
                    http.post(
                        "$baseUrl/scout/${state.form.teamNumber}/${state.form.matchId}",
                        body: jsonEncode(state.form.toJson()),
                        headers: {"Content-Type": "application/json"});
                    Navigator.pop(context);
                  },
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
