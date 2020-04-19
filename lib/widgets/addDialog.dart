import 'package:flutter/material.dart';

Widget addDialog(BuildContext context) {
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
            FlatButton(child: Text("Cancel"), onPressed: () => {
              Navigator.pop(context)
            }),
            Padding(padding: EdgeInsets.only(left:10)),
            RaisedButton(child: Text("Add"), onPressed: () => {
              Navigator.pop(context),
            })
          ],
        )
      )
    ],
  );
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
    );
  }
}