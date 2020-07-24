import 'package:flutter/material.dart';
import 'package:frc_scouting/main.dart';
import 'package:http/http.dart' as http;

String _eventName;
String _blueAllianceId;

class AddDialog extends StatelessWidget {
  const AddDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              EventNameInput(),
              EventIdInput(),
            ],
          ),
        ),
        Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                    child: Text("Cancel"),
                    onPressed: () => {Navigator.pop(context)}),
                Padding(padding: EdgeInsets.only(left: 10)),
                RaisedButton(
                    child: Text("Add"),
                    onPressed: () => {
                          http.post("$baseUrl/addevents", body: {
                            "event_name": _eventName,
                            "blue_alliance_id": _blueAllianceId
                          }),
                          Navigator.pop(context),
                        })
              ],
            ))
      ],
    );
  }
}

class EventNameInput extends StatefulWidget {
  @override
  _EventNameInputState createState() {
    return _EventNameInputState();
  }
}

class _EventNameInputState extends State<EventNameInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Event Name",
      ),
      onChanged: (newValue) => _eventName = newValue,
    );
  }
}

class EventIdInput extends StatefulWidget {
  @override
  _EventIdInputState createState() {
    return _EventIdInputState();
  }
}

class _EventIdInputState extends State<EventIdInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
        decoration: InputDecoration(
          hintText: "Blue Alliance Event Id",
        ),
        onChanged: (newValue) => _blueAllianceId = newValue);
  }
}
