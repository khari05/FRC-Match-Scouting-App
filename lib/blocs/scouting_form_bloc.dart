import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frc_scouting/blocs/blocs.dart';
import 'package:frc_scouting/models/models.dart';
import 'package:frc_scouting/repositories/repositories.dart';

class ScoutingFormBloc extends Bloc<ScoutingFormEvent, ScoutingFormState> {
  final ScoutingDataRepository scoutingDataRepository;
  final int teamNumber;
  final int matchId;

  ScoutingFormBloc({
    @required this.scoutingDataRepository,
    @required this.teamNumber,
    @required this.matchId,
  })  : assert(scoutingDataRepository != null),
        super(ScoutingFormInitial());

  @override
  Stream<ScoutingFormState> mapEventToState(ScoutingFormEvent event) async* {
    if (event is FormRequested) {
      yield ScoutingFormLoadInProgress();
      try {
        final ScoutingData form =
            await scoutingDataRepository.getForm(teamNumber, matchId);
        yield ScoutingFormLoadSuccess(form: form);
      } catch (e) {
        print(e);
        yield ScoutingFormLoadError();
      }
    }
    if (event is FormDataChanged) {
      yield ScoutingFormLoadSuccess(form: event.newForm);
    }
  }
}
