import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:frc_scouting/blocs/blocs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frc_scouting/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:frc_scouting/repositories/event_api_client.dart';
import 'package:frc_scouting/repositories/repositories.dart';
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {
  @override
  Future<http.Response> get(dynamic url, {Map<String, String> headers}) async {
    return http.Response(
        json.encode([
          {
            "id": 1,
            "name": "2020 Dalton Scouting",
            "blue_alliance_id": "2020gadal"
          }
        ]),
        200);
  }
}

void main() {
  group('EventBloc', () {
    EventBloc eventBloc;

    setUp(() {
      eventBloc = EventBloc(
        eventRepository: EventRepository(
          eventApiClient: EventApiClient(httpClient: MockClient()),
        ),
      );
    });

    test('Initial state is EventInitial', () {
      expect(true, eventBloc.state is EventInitial);
    });

    blocTest("EventBloc parses the http.Response when events are requested",
        build: () => eventBloc,
        act: (EventBloc bloc) {
          bloc.add(EventsRequested());
          print(bloc.state);
        },
        expect: [
          EventLoadInProgress(),
          EventLoadSuccess(events: [
            Event(
                id: 1,
                name: "2020 Dalton Scouting",
                blueAllianceId: "2020gadal")
          ])
        ]);
  });
}
