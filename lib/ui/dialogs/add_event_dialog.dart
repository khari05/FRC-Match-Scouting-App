import 'package:flutter/material.dart';
import 'package:frc_scouting/main.dart';
import 'package:http/http.dart' as http;

class AddEventDialog extends StatelessWidget {
  const AddEventDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _eventName;
    String _blueAllianceId;
    return SimpleDialog(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  hintText: "Event Name",
                ),
                onChanged: (newValue) => _eventName = newValue,
              ),
              TextField(
                  decoration: InputDecoration(
                    hintText: "Blue Alliance Event Id",
                  ),
                  onChanged: (newValue) => _blueAllianceId = newValue)
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
              ),
              RaisedButton(
                child: Text("Add"),
                onPressed: () {
                  http.post("$baseUrl/addevents", body: {
                    "event_name": _eventName,
                    "blue_alliance_id": _blueAllianceId
                  });
                  Navigator.pop(context, true);
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
