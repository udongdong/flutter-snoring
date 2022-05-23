import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<_ChartData> chartData = <_ChartData>[];

  void addData(_ChartData _chartData) {
    chartData.add(_chartData);
  }

  @override
  Widget build(BuildContext context) {
    if (chartData.length >= 100) {
      chartData.removeAt(0);
    }

    return SfCartesianChart(
      series: <LineSeries<_ChartData, double>>[
        LineSeries<_ChartData, double>(
            dataSource: chartData,
            xAxisName: 'Time',
            yAxisName: 'dB',
            name: 'dB values over time',
            xValueMapper: (_ChartData value, _) => value.frames,
            yValueMapper: (_ChartData value, _) => value.maxDB,
            animationDuration: 0),
      ],
    );
  }
}


class _ChartData {
  final double? maxDB;
  final double? meanDB;
  final double frames;

  _ChartData(this.maxDB, this.meanDB, this.frames);
}