import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class TeamChartPage extends StatelessWidget {
  final List<FlSpot> data;
  final String title;
  final double maxY;
  final double horizontalInterval;

  const TeamChartPage(
      {Key key,
      @required this.data,
      @required this.title,
      this.maxY,
      this.horizontalInterval})
      : super(key: key);

  static const List<Color> gradientColors = [
    Colors.lightBlueAccent,
    Colors.tealAccent
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (Text(title)),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * .8,
          height: MediaQuery.of(context).size.height * .5,
          child: LineChart(
            LineChartData(
              minY: 0,
              maxY: maxY,
              minX: 1,
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                horizontalInterval: horizontalInterval,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Colors.white38,
                    strokeWidth: 1,
                  );
                },
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: data,
                  isCurved: true,
                  colors: gradientColors,
                  barWidth: 5,
                  isStrokeCapRound: true,
                  belowBarData: BarAreaData(
                    show: true,
                    colors: gradientColors
                        .map((color) => color.withOpacity(0.3))
                        .toList(),
                  ),
                ),
              ],
              titlesData: FlTitlesData(
                leftTitles: SideTitles(
                    showTitles: true,
                    interval: horizontalInterval,
                    getTextStyles: (value) =>
                        Theme.of(context).textTheme.bodyText1),
                bottomTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (value) =>
                        Theme.of(context).textTheme.bodyText1),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: Colors.white38, width: 1),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
