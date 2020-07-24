import 'package:flutter/material.dart';
import 'package:frc_scouting/main.dart';
import 'package:frc_scouting/widgets/TeamListView.dart';
import 'package:frc_scouting/widgets/MatchView.dart';
import 'package:http/http.dart' as http;

class EventPage extends StatefulWidget {
  final String eventKey;
  final String eventName;
  const EventPage({Key key, @required this.eventKey, @required this.eventName})
      : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = [
      MatchView(eventKey: widget.eventKey),
      TeamListView(eventKey: widget.eventKey)
    ];

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.eventName),
          actions: [
            _index == 0
                ? Container()
                : FlatButton(
                    child: Icon(Icons.refresh),
                    onPressed: () {
                      http.put("$baseUrl/updateteams/${widget.eventKey}");
                      Navigator.pop(context);
                    },
                  )
          ],
        ),
        body: Center(
          child: _widgetOptions[_index],
        ),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).bottomAppBarColor,
            currentIndex: _index,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.trending_up), title: Text("Matches")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people), title: Text("Teams")),
            ],
            onTap: (newValue) => setState(() => _index = newValue)));
  }
}
