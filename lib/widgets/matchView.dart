import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frc_scouting/main.dart';
import 'package:frc_scouting/widgets/scoutingform/scoutingView.dart';
import 'package:http/http.dart' as http;

dynamic responseJson;

Widget matchView(BuildContext context, String eventKey, String eventName) {
  Future<http.Response> _matches = http.get("$url/matches/$eventKey");
  return FutureBuilder(
    future: _matches,
    builder: (BuildContext context, AsyncSnapshot<http.Response> response) {
      if (response.hasData && response.data.body != "[]") {
          return Scaffold(
            appBar: AppBar(
              title: Text(eventName),
            ),
            body: Center(
              child: matchListView(context, jsonDecode(response.data.body), eventKey),
            ),
          );
      } else if (response.hasError) {
        print("response has an error: " + response.error.toString());
        return Scaffold();
      } else {
        print("error: no data");
        return Scaffold();
      }
    }
  );
}
Widget matchListView(BuildContext context, List responseJson, String eventKey) {
  return ListView.builder(
    itemCount: responseJson.length,
    itemBuilder: (context, index) {
      return Container(
        padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Qual " + matchNumber(responseJson[index]["match_number"]), textAlign: TextAlign.center,),
            Column(
              children: <Widget>[
                Container(
                  color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      teamButton(context, index, responseJson, "red1"),
                      teamButton(context, index, responseJson, "red2"),
                      teamButton(context, index, responseJson, "red3")
                    ],
                  )
                ),
                Container(
                  color: Colors.blueAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      teamButton(context, index, responseJson, "blue1"),
                      teamButton(context, index, responseJson, "blue2"),
                      teamButton(context, index, responseJson, "blue3")
                    ],
                  )
                )
              ],
            )
          ]
        )
      );
    }
  );
}

Widget teamButton(BuildContext context, int index, responseJson, String station) {
  return FlatButton(
    child: Text(responseJson[index][station].toString()),
    onPressed: () => {
      Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context){
          return scoutingView(context, responseJson[index][station], responseJson[index]["id"]);
        })
      )
    },
  );
}

String matchNumber(int number) {
  return (number<10) ? "0"+number.toString() : number.toString();
}