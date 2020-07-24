import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frc_scouting/blocs/simple_bloc_observer.dart';
import 'package:frc_scouting/repositories/event_api_provider.dart';
import 'package:frc_scouting/repositories/repositories.dart';
import 'package:frc_scouting/ui/views/event_view.dart';
import 'package:http/http.dart' as http;

// initialize constants
final String baseUrl = "http://localhost:3000";

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme:
            ThemeData(brightness: Brightness.dark, primarySwatch: Colors.teal),
        home:
            EventView(eventRepository: EventRepository(eventApiClient: EventApiClient(httpClient: http.Client())),) // need to put app contents in a subclass in order to be able to call navigator
        );
  }
}
