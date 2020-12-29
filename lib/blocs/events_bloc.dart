import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frc_scouting/blocs/blocs.dart';
import 'package:frc_scouting/models/models.dart';
import 'package:frc_scouting/repositories/repositories.dart';

class EventBloc extends Bloc<EventsEvent, EventState> {
  final EventRepository eventRepository;

  EventBloc({@required this.eventRepository})
      : assert(eventRepository != null),
        super(EventInitial());

  @override
  Stream<EventState> mapEventToState(EventsEvent event) async* {
    if (event is EventsRequested) {
      yield EventLoadInProgress();
      try {
        final List<Event> events = await eventRepository.fetchAllEvents();
        yield EventLoadSuccess(events: events);
      } catch (e) {
        print(e);
        yield EventLoadFailure();
      }
    }
  }
}
