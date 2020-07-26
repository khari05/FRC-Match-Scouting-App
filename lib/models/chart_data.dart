import 'package:flutter/material.dart';

class ChartData {
  int matchNumber;
  int data;

  ChartData({@required this.matchNumber, @required this.data});

  static List<ChartData> fromJson(List<dynamic> parsedJson) {
    List<ChartData> data = [];
    parsedJson.forEach((element) {
      data.add(ChartData(
          matchNumber: element["matchNumber"], data: element["data"]));
    });
    return data;
  }
}
