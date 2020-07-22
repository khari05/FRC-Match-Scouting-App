import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frc_scouting/main.dart';
import 'package:frc_scouting/src/widgets/EventPage.dart';
import 'package:http/http.dart' as http;

class EventView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<http.Response> _events = http.get(url + "/events/");
    return FutureBuilder(
        future: _events,
        builder: (BuildContext context, AsyncSnapshot<http.Response> response) {
          if (response.hasData) {
            return Container(
              padding: EdgeInsets.all(5),
              child: EventList(responseJson: jsonDecode(response.data.body)),
            );
          } else if (response.hasError) {
            print("response has an error: " + response.error.toString());
            return Container();
          } else {
            print("error: no data");
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class EventList extends StatelessWidget {
  final List<Map<String, dynamic>> responseJson;

  const EventList({Key key, this.responseJson}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: responseJson.length * 2,
        separatorBuilder: (context, index) =>
            Padding(padding: EdgeInsets.all(2.5)),
        itemBuilder: (context, index) {
          return RaisedButton(
              child: ListTile(
                title: Text(responseJson[index]["name"]),
                trailing: Icon(Icons.arrow_forward),
              ),
              onPressed: () => {
                    Navigator.push(context, MaterialPageRoute<void>(
                      // when clicked, it opens the match list and scouting for said item
                      builder: (BuildContext context) {
                        return EventPage(
                            eventKey: responseJson[index]
                                ["blue_alliance_id"],
                            eventName: responseJson[index]["name"]);
                      },
                    )),
                  });
        });
  }
}
