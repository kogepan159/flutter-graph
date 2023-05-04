import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FlChart extends StatefulWidget {
  FlChart(this.records, this.section, {Key? key}) : super(key: key);
  List<double> records;
  int section;
  @override
  State<FlChart> createState() => _FlChartState();
}

class _FlChartState extends State<FlChart> {
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: 500,
      height: 300,
      child: LineChart(
        // 折線グラフ
        LineChartData(
          // 折れ線グラフデータ
          // read about it in the LineChartData section
            maxX: widget.records.length * 1.0, // x 軸の最大 x を取得します。null の場合、値は入力 lineBars から読み取られます
            maxY: widget.records.reduce(max) + widget.records.reduce(max)/10, // y 軸の最大 y を取得します。null の場合、値は入力 lineBars から読み取られます
            minX: 1, // x 軸の最小 x を取得します。null の場合、値は入力 lineBars から読み取られます
            minY: widget.records.reduce(min) - widget.records.reduce(max)/10, // y 軸の最小 y を取得します。null の場合、値は入力 lineBars から読み取られます
            gridData:FlGridData(verticalInterval: 1),
            lineBarsData: [
              // 線を表示するためのデータ
              LineChartBarData(
                // この中に線の色やサイズを書く!
                  isCurved: false,
                  barWidth: 3.0, // 線の幅
                  color: Colors.green[300], // 線の色
                  spots: makeSpots())
            ]),
        swapAnimationDuration: const Duration(milliseconds: 150),
        swapAnimationCurve: Curves.linear,
      ),
    );
  }

  List<FlSpot> makeSpots() {
    List<FlSpot> spots = [];
    double index = 1;
    for (double record in widget.records) {
      spots.add(FlSpot(index, record));
      index += 1.0;
    }
    return spots;
  }
}