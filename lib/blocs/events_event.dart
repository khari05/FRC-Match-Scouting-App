import 'package:equatable/equatable.dart';

abstract class EventsEvent extends Equatable {
  const EventsEvent();
}

class EventsRequested extends EventsEvent {
  const EventsRequested();

  @override
  List<Object> get props => [];
}
