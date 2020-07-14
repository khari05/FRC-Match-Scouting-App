import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:frc_scouting/classes/chart_data.dart';

class TeamChartView extends StatelessWidget {
  final List<dynamic> chartData;
  final String title;

  const TeamChartView({Key key, @required this.chartData, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ChartData> data = [
      ChartData(data: 4, matchNumber: 1),
      ChartData(data: 6, matchNumber: 2),
      ChartData(data: 5, matchNumber: 3),
      ChartData(data: 7, matchNumber: 4),
      ChartData(data: 8, matchNumber: 5),
      ChartData(data: 6, matchNumber: 6),
      ChartData(data: 5, matchNumber: 7),
      ChartData(data: 7, matchNumber: 8),
    ];
    // chartData.forEach((element) {
    //   data.add(ChartData(
    //     matchNumber: element["matchNumber"], data: element["data"]
    //   ));
    // });
    List<Series<ChartData, int>> series = [
      Series(
        id: "",
        data: data,
        domainFn: (ChartData data, _) => data.matchNumber,
        measureFn: (ChartData data, _) => data.data,
        colorFn: (ChartData data, _) => ColorUtil.fromDartColor(Colors.teal)
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Container(
          height: 400,
            child: LineChart(series, animate: true),
        ),
      ),
    );
  }
}
