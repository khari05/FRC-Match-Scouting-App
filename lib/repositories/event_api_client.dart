import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frc_scouting/main.dart';
import 'package:frc_scouting/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class EventApiClient {
  final http.Client httpClient;

  EventApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<List<Event>> fetchEventList() async {
    final response = await httpClient.get("$baseUrl/events");

    if (response.statusCode != 200) throw Exception('Error loading Events');

    List<Event> events = [];
    json.decode(response.body).forEach((element) {
      events.add(Event.fromJson(element));
    });
    return events;
  }
}
