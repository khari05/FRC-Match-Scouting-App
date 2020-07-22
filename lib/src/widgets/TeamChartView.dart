import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:frc_scouting/src/models/chart_data.dart';

class TeamChartView extends StatelessWidget {
  final List<dynamic> chartData;
  final String title;

  const TeamChartView({Key key, @required this.chartData, @required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //* We need to create an axis spec so the chart will render using colors that will look good in dark theme.
    NumericAxisSpec axis = NumericAxisSpec(
        renderSpec: GridlineRendererSpec(
            labelStyle:
                TextStyleSpec(fontSize: 10, color: MaterialPalette.white),
            lineStyle: LineStyleSpec(
                thickness: 0, color: MaterialPalette.gray.shadeDefault)));

    List<ChartData> data = [];
    chartData.forEach((element) {
      data.add(ChartData(
          matchNumber: element["matchNumber"], data: element["data"]));
    });
    List<Series<ChartData, int>> series = [
      Series(
          id: "",
          data: data,
          domainFn: (ChartData data, _) => data.matchNumber,
          measureFn: (ChartData data, _) => data.data,
          colorFn: (ChartData data, _) => ColorUtil.fromDartColor(Colors.teal))
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Container(
          height: 400,
          child: LineChart(
            series,
            animate: true,
            defaultRenderer: LineRendererConfig(includePoints: true),
            primaryMeasureAxis: axis,
            domainAxis: axis,
          ),
        ),
      ),
    );
  }
}
