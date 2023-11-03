import 'package:subway_congestion/presentation/resources/app_resources.dart';
import 'package:subway_congestion/util/extensions/color_extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../header.dart';
import '../../../screen/congestionDetail_screen.dart';

class _BarChart extends StatelessWidget {
  const _BarChart();

  @override
  Widget build(BuildContext context) {
    // var max = tmp1[0];
    List<int> indices = [0, 6, 12, 18, 25];

    double max = 0; // 최솟값으로 초기화

    for (int index in indices) {
      if (index >= 0 && index < tmp1.length) { // 주어진 인덱스가 유효한지 확인
        if (tmp1[index] > max) {
          max = tmp1[index];
        }
      }
    }

    return BarChart(

      BarChartData(

        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData:  FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: max+20,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 10,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: AppColors.contentColorCyan,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: AppColors.contentColorRed.darken(20),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '6시';
        break;
      case 1:
        text = '9시';
        break;
      case 2:
        text = '12시';
        break;
      case 3:
        text = '15시';
        break;
      case 4:
        text = '18시';
        break;
      case 5:
        text = '21시';
        break;
      case 6:
        text = '24시';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 5,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 100,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles:  AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles:  AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles:  AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          Color(0xFF22726E),
          Color(0xFF4CB3AD),
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: tmp1[0],
              gradient: _barsGradient,
              width: 15,
            )
          ],
          showingTooltipIndicators: [0],
        ),

        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: tmp1[6],
              gradient: _barsGradient,
              width: 20,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: tmp1[12],
              gradient: _barsGradient,
              width: 20,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: tmp1[18],
              gradient: _barsGradient,
              width: 20,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: tmp1[24],
              gradient: _barsGradient,
              width: 20,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: tmp1[30],
              gradient: _barsGradient,
              width: 20,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              toY: tmp1[35],
              gradient: _barsGradient,
              width: 20,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}

class BarChartSample3 extends StatefulWidget {
  const BarChartSample3({super.key});

  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: getColor('main2'),
        // centerTitle: true,
        elevation: 0.0,
        leading: Container(),
        title: Center(
          child:Text(
            '시간대별 혼잡도 통계      ',
            style: TextStyle(
              color: AppColors.contentColorRed,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

        ),
      ),

      body : Container(
        color: getColor('main2'),
        child: const AspectRatio(

          aspectRatio: 0.6,
          child:
          _BarChart(),
        ),
      ),




    );
  }
}
