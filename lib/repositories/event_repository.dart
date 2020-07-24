import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frc_scouting/repositories/event_api_provider.dart';
import 'package:frc_scouting/models/event.dart';

class EventRepository {
  final EventApiClient eventApiClient;

  EventRepository({@required this.eventApiClient}) : assert(eventApiClient != null);

  Future<List<Event>> fetchAllEvents() async =>
      await eventApiClient.fetchEventList();
}
