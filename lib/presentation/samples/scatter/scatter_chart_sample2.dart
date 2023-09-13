import 'package:subway_congestion/presentation/resources/app_resources.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../widget/myMenu.dart';

class ScatterChartSample2 extends StatefulWidget {
  const ScatterChartSample2({super.key});

  @override
  State<StatefulWidget> createState() => _ScatterChartSample2State();
}

class _ScatterChartSample2State extends State {
  int touchedIndex = -1;

  Color greyColor = Colors.grey;

  List<int> selectedSpots = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(
          '노선도',
          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1),),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(84, 162, 154, 1),
      ),
      drawer: myMenu(),

      body : AspectRatio(
        aspectRatio: 1,
        child: ScatterChart(
          ScatterChartData(
            scatterSpots: [
              ScatterSpot(
                2,
                -4,
                color: selectedSpots.contains(0)
                    ? AppColors.contentColorYellow
                    : AppColors.contentColorRed,
                radius: 20,

              ),
              ScatterSpot(
                5,
                -4,
                color: selectedSpots.contains(1)
                    ? AppColors.contentColorYellow
                    : AppColors.contentColorRed,
                radius: 20,
              ),
              ScatterSpot(
                8,
                -4,
                color: selectedSpots.contains(2)
                    ? AppColors.contentColorYellow
                    : AppColors.contentColorRed,
                radius: 20,
              ),
              ScatterSpot(
                2,
                4,
                color: selectedSpots.contains(3)
                    ? AppColors.contentColorYellow
                    : AppColors.contentColorRed,
                radius: 20,
              ),
              ScatterSpot(
                5,
                4,
                color: selectedSpots.contains(4)
                    ? AppColors.contentColorYellow
                    : AppColors.contentColorRed,
                radius: 20,
              ),
              ScatterSpot(
                8,
                4,
                color: selectedSpots.contains(5)
                    ? AppColors.contentColorYellow
                    : AppColors.contentColorRed,
                radius: 20,
              ),
              ScatterSpot(
                2,
                0,
                color: selectedSpots.contains(6)
                    ? AppColors.contentColorYellow
                    : AppColors.contentColorRed,
                radius: 20,
              ),
              ScatterSpot(
                5,
                0,
                color: selectedSpots.contains(7)
                    ? AppColors.contentColorYellow
                    : AppColors.contentColorRed,
                radius: 20,
              ),
              ScatterSpot(
                8,
                0,
                color: selectedSpots.contains(8)
                    ? AppColors.contentColorYellow
                    : AppColors.contentColorRed,
                radius: 20,
              ),
            ],
            minX: 0,
            maxX: 10,
            minY: 0,
            maxY: 10,
            borderData: FlBorderData(
              show: false,
            ),
            gridData: FlGridData(
              show: true,
              drawHorizontalLine: true,
              checkToShowHorizontalLine: (value) => true,
              getDrawingHorizontalLine: (value) =>  FlLine(
                color: AppColors.gridLinesColor,
              ),
              drawVerticalLine: true,
              checkToShowVerticalLine: (value) => true,
              getDrawingVerticalLine: (value) =>  FlLine(
                color: AppColors.gridLinesColor,
              ),
            ),
            titlesData:  FlTitlesData(
              show: false,
            ),
            showingTooltipIndicators: selectedSpots,
            scatterTouchData: ScatterTouchData(
              enabled: true,
              handleBuiltInTouches: false,
              mouseCursorResolver:
                  (FlTouchEvent touchEvent, ScatterTouchResponse? response) {
                return response == null || response.touchedSpot == null
                    ? MouseCursor.defer
                    : SystemMouseCursors.click;
              },
              touchTooltipData: ScatterTouchTooltipData(
                tooltipBgColor: Colors.black,
                getTooltipItems: (ScatterSpot touchedBarSpot) {
                  return ScatterTooltipItem(
                    'X: ',
                    textStyle: TextStyle(
                      height: 1.2,
                      color: Colors.grey[100],
                      fontStyle: FontStyle.italic,
                    ),
                    bottomMargin: 10,
                    children: [
                      TextSpan(
                        text: '${touchedBarSpot.x.toInt()} \n',
                        style: const TextStyle(
                          color: Colors.red,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'Y: ',
                        style: TextStyle(
                          height: 1.2,
                          color: Colors.grey[100],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      TextSpan(
                        text: touchedBarSpot.y.toInt().toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              ),
              touchCallback:
                  (FlTouchEvent event, ScatterTouchResponse? touchResponse) {
                if (touchResponse == null || touchResponse.touchedSpot == null) {
                  return;
                }
                if (event is FlTapUpEvent) {
                  final sectionIndex = touchResponse.touchedSpot!.spotIndex;
                  setState(() {
                    if (selectedSpots.contains(sectionIndex)) {
                      selectedSpots.remove(sectionIndex);
                    } else {
                      selectedSpots.add(sectionIndex);
                    }
                  });
                }
              },
            ),
          ),
        ),
      ),

    );


  }
}
