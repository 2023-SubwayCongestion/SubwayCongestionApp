import 'package:subway_congestion/presentation/resources/app_resources.dart';
import 'package:subway_congestion/presentation/widgets/indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../header.dart';

class PieChartSample1 extends StatefulWidget {
  const PieChartSample1({super.key});

  @override
  State<StatefulWidget> createState() => PieChartSample1State();
}

class PieChartSample1State extends State {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 14,
          ),
          Text(
            '호차별 혼잡도 통계',
            style: TextStyle(
              color: AppColors.contentColorRed,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          const SizedBox(
            height: 28,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Indicator(
                color: Color(0xFF22726E),
                text: '1호차',
                isSquare: false,
                size: touchedIndex == 0 ? 18 : 16,
                textColor: touchedIndex == 0
                    ? AppColors.contentColorCyan
                    : AppColors.pageBackground,

              ),
              Indicator(
                color: Color(0xFF4CB3AD),
                text: '2호차',
                isSquare: false,
                size: touchedIndex == 1 ? 18 : 16,
                textColor: touchedIndex == 1
                    ? AppColors.contentColorCyan
                    : AppColors.pageBackground,
              ),
              Indicator(
                color: Color(0xFF6FD5CF),
                text: '3호차',
                isSquare: false,
                size: touchedIndex == 2 ? 18 : 16,
                textColor: touchedIndex == 2
                    ? AppColors.contentColorCyan
                    : AppColors.pageBackground,
              ),
              Indicator(
                color: Color(0xFFDFFFFD),
                text: '4호차',
                isSquare: false,
                size: touchedIndex == 3 ? 18 : 16,
                textColor: touchedIndex == 3
                    ? AppColors.contentColorCyan
                    : AppColors.pageBackground,
              ),
              Indicator(
                color: Color(0xFF2F8C88),
                text: '5호차',
                isSquare: false,
                size: touchedIndex == 4 ? 18 : 16,
                textColor: touchedIndex == 4
                    ? AppColors.contentColorCyan
                    : AppColors.pageBackground,
              ),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  startDegreeOffset: 180,
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 1,
                  centerSpaceRadius: 0,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(
      5,
      (i) {
        final isTouched = i == touchedIndex;
        const color0 = Color(0xFF22726E);
        const color1 = Color(0xFF4CB3AD);
        const color2 = Color(0xFF6FD5CF);
        const color3 = Color(0xFFDFFFFD);
        const color4 = Color(0xFF2F8C88);

        switch (i) {
          case 0:
            return PieChartSectionData(
              color: color0,
              value: 25,
              title: '',
              radius: 170,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(
                      color: AppColors.contentColorWhite, width: 6)
                  : BorderSide(
                      color: AppColors.contentColorWhite.withOpacity(0)),
            );
          case 1:
            return PieChartSectionData(
              color: color1,
              value: 25,
              title: '',
              radius: 160,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(
                      color: AppColors.contentColorWhite, width: 6)
                  : BorderSide(
                      color: AppColors.contentColorWhite.withOpacity(0)),
            );
          case 2:
            return PieChartSectionData(
              color: color2,
              value: 25,
              title: '',
              radius: 190,
              titlePositionPercentageOffset: 0.6,
              borderSide: isTouched
                  ? const BorderSide(
                      color: AppColors.contentColorWhite, width: 6)
                  : BorderSide(
                      color: AppColors.contentColorWhite.withOpacity(0)),
            );
          case 3:
            return PieChartSectionData(
              color: color3,
              value: 25,
              title: '',
              radius: 170,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(
                      color: AppColors.contentColorWhite, width: 6)
                  : BorderSide(
                      color: AppColors.contentColorWhite.withOpacity(0)),
            );
          case 4:
            return PieChartSectionData(
              color: color4,
              value: 25,
              title: '',
              radius: 180,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(
                  color: AppColors.contentColorWhite, width: 6)
                  : BorderSide(
                  color: AppColors.contentColorWhite.withOpacity(0)),
            );
          default:
            throw Error();
        }
      },
    );
  }
}
