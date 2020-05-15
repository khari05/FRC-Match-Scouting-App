import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frc_scouting/main.dart';
import 'package:frc_scouting/widgets/matchView.dart';
import 'package:http/http.dart' as http;

Widget eventView(BuildContext context) {
  Future<http.Response> _events = http.get(url + "/events/");
  return FutureBuilder(
    future: _events,
    builder: (BuildContext context, AsyncSnapshot<http.Response> response) {
      if (response.hasData) {
        return Container(
          padding: EdgeInsets.all(5),
          child: eventList(context, jsonDecode(response.data.body)),
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
    }
  );
}

Widget eventList(BuildContext context, List responseJson) {
  return ListView.builder(
    itemCount: responseJson.length * 2,
    itemBuilder: (context, index) {
      if (index % 2 == 0) {
        return RaisedButton(
          child: ListTile(
            title: Text(responseJson[index~/2]["name"]),
            trailing: Icon(Icons.arrow_forward),
          ),
          onPressed: () => {
            Navigator.push(context, MaterialPageRoute<void>( // when clicked, it opens the match list and scouting for said item
              builder: (BuildContext context) {
                return matchView(context, responseJson[index~/2]["blue_alliance_id"], responseJson[index~/2]["name"]);
              },
            )),
          });
      } else {
        return Padding(padding: EdgeInsets.all(2.5));
      }
    }
  );
}