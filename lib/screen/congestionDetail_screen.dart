import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:subway_congestion/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:subway_congestion/model/model_congestion.dart';
import 'package:subway_congestion/widget/congestion_view.dart';
import 'package:subway_congestion/widget/custom_button.dart';

class CongestionDetailScreen extends StatefulWidget {
  final String subwayName;
  final String direction1;
  final String direction2;
  final firestore = FirebaseFirestore.instance;
  
  CongestionDetailScreen({
    super.key,
    required this.subwayName,
    required this.direction1,
    required this.direction2,
  });
  

  @override
  State<CongestionDetailScreen> createState() => _CongestionDetailScreenState();
}

class _CongestionDetailScreenState extends State<CongestionDetailScreen> {


  @override
  void initState() {
    super.initState();
    fetchData();
  }
  List<List<DocumentSnapshot>> splitDocumentsByWeekday(List<DocumentSnapshot> documents) {
    List<DocumentSnapshot> weekdays = [];
    List<DocumentSnapshot> saturday = [];
    List<DocumentSnapshot> holiday = [];

    for (DocumentSnapshot document in documents) {
      String weekday = document['요일구분'];

      if (weekday == '평일') {
        weekdays.add(document);
      } else if (weekday == '토요일') {
        saturday.add(document);
      } else if (weekday == '공휴일') {
        holiday.add(document);
      }
    }

    return [weekdays, saturday, holiday];
  }
  void fetchData() async {
    List<DocumentSnapshot> congestionDocuments = await getCongestionDocuments();

    List<List<DocumentSnapshot>> splittedDocuments = splitDocumentsByWeekday(congestionDocuments);
    List<DocumentSnapshot> weekdays = splittedDocuments[0];
    List<DocumentSnapshot> saturday = splittedDocuments[1];
    List<DocumentSnapshot> holiday = splittedDocuments[2];

// 분리된 문서 리스트를 원하는 방식으로 활용
// 예: 각 문서의 데이터에 접근, 출력 등
    for (DocumentSnapshot document in weekdays) {
      print('평일부분임');
      print(document.data()); // 문서 데이터 출력 예시
    }

    for (DocumentSnapshot document in saturday) {
      print('토요일부분임');
      print(document.data()); // 문서 데이터 출력 예시
    }

    for (DocumentSnapshot document in holiday) {
      print('공휴일부분임');
      print(document.data()); // 문서 데이터 출력 예시
    }



  }

  List<List<dynamic>> convertTo2DList(Map<String, dynamic> data) {
    List<List<dynamic>> result = [];
    List<dynamic> keys = data.keys.toList();
    List<dynamic> values = data.values.toList();

    int length = keys.length;

    for (int i = 0; i < length; i++) {
      List<dynamic> row = [keys[i], values[i]];
      result.add(row);
    }

    return result;
  }




  Future<List<DocumentSnapshot>> getCongestionDocuments() async {
    List<DocumentSnapshot> documents = [];

    QuerySnapshot snapshot = await widget.firestore
        .collection('2022congestion')
        .where('출발역', isEqualTo: widget.subwayName.substring(0,widget.subwayName.length-1))
        .get();

    documents = snapshot.docs;

    return documents;
  }



  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];bool showAvg = false;
  int _selectedWidgetIndex = 0;

  

  @override
  Widget build(BuildContext context) {

    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      fetchData();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: getColor('main2'),
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.cancel_outlined,
            size: 30,
          ),
          color: getColor('main1'),
          // X 버튼의 색상을 변경합니다. 원하는 색상으로 변경하세요.
          onPressed: () {
            Navigator.of(context).pop(); // 뒤로 가기 버튼과 동일한 동작을 수행합니다.
          },
        ),
        title: Center(
          child: Text(
            widget.subwayName + ' 시간대별 혼잡도 통계     ',
            style: TextStyle(
                color: getColor('main1'),
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        color: getColor('main2'),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),

            SafeArea(
              child: Column(
                children: <Widget>[
                  TextButton(
                    child: Text(
                      showAvg ? '평균 혼잡율 보기' : '시간대별 혼잡율 보기',
                      style: TextStyle(
                          color: getColor('main1'),
                          // showAvg ? Colors.white.withOpacity(0.5) : Colors.white),
                      )),
                    onPressed: () {
                      print('click');
                      setState(() {
                        showAvg = !showAvg;
                      });
                    },
                  ),
                  AspectRatio(
                    aspectRatio: 3 / 2,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        color: getColor('main1')),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        child: LineChart(
                          showAvg ? avgChart() : mainChart(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Text('(단위 : %,  단위기준 : 열차 1량의 승차인원 = 160명 = 100%)'),
            SizedBox(
              height: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '< 혼잡도 수치에 따른 체감정도 >',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  '34% - 서있는 사람 없이 좌석에 모두 앉은 상태',
                  textAlign: TextAlign.left,
                ),SizedBox(height: 10),
                Text(
                  '100% - 한 칸에 160명이 탑승한 상태',
                  textAlign: TextAlign.left,
                ),SizedBox(height: 10),
                Text(
                  '125% - 이동시 다소 부딪힐 정도의 상태',
                  textAlign: TextAlign.left,
                ),SizedBox(height: 10),
                Text(
                  '140% - 출입문 주변 혼잡, 이동시 어깨 부딪힐 정도의 상태',
                  textAlign: TextAlign.left,
                ),SizedBox(height: 10),
                Text(
                  '200% 이상 - 밀착되고 숨이 막히는 수준',
                  textAlign: TextAlign.left,
                ),SizedBox(height: 10),
                Text(
                  '230% - 수용 한계점',
                  textAlign: TextAlign.left,
                ),
              ],
            ),




          ],
        ),
      ),



    );
  }




    LineChartData mainChart() {
      return LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Color(0xff37434d),
              strokeWidth: 0.5,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: Color(0xff37434d),
              strokeWidth: 0.5,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,

          bottomTitles: AxisTitles(
            axisNameWidget: Text(
              '시간',
              style: TextStyle(
                fontSize: 10,
                // color: mainLineColor,
                fontWeight: FontWeight.bold,

              ),
            ),
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 18,
              interval: 1,
              getTitlesWidget: bottomTitleWidgets,
            ),
          ),

          leftTitles: AxisTitles(
            axisNameSize: 20,
            axisNameWidget: const Text(
              '혼잡도(%)',
              style: TextStyle(
                // color: AppColors.mainTextColor2,
              ),
            ),
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              reservedSize: 40,
              getTitlesWidget: leftTitleWidgets,
            ),
          ),

          //오른쪽 0 50 100 150 지우기
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            )
          ),

          //위쪽 0 50 100 150 지우기
          topTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              )
          ),

        ),
        borderData: FlBorderData(
            show: true,
            border: Border.all(color: const Color(0xff37434d), width: 3)),
        minX: 6,
        maxX: 24,
        minY: 0,
        maxY: 200,

        lineBarsData: [

          LineChartBarData(
            show: true,
            spots: [
              FlSpot(6, 21.7),
              FlSpot(6.5, 23.7),
              FlSpot(7, 41.9),
              FlSpot(7.5, 52.4),
              FlSpot(8, 70.8),
              FlSpot(8.5, 78.6),
              FlSpot(9, 48.5),
              FlSpot(9.5, 58.5),
              FlSpot(10, 30.1),
              FlSpot(10.5, 38.6),
              FlSpot(11, 35.9),
              FlSpot(11.5, 39),
              FlSpot(12, 34.6),
              FlSpot(12.5, 38.8),
              FlSpot(13, 37.9),
              FlSpot(13.5, 36.1),
              FlSpot(14, 27),
              FlSpot(14.5, 38.6),
              FlSpot(15, 37.1),
              FlSpot(15.5, 41.1),
              FlSpot(16, 44.6),
              FlSpot(16.5, 46.3),
              FlSpot(17, 42.5),
              FlSpot(17.5, 38),
              FlSpot(18, 48.1),
              FlSpot(18.5, 38.3),
              FlSpot(19, 26.3),
              FlSpot(19.5, 21.9),
              FlSpot(20, 18.3),
              FlSpot(20.5, 16.2),
              FlSpot(21, 21.7),
              FlSpot(21.5, 25.8),
              FlSpot(22, 26.2),
              FlSpot(22.5, 22.3),
              FlSpot(23, 17.9),
              FlSpot(23.5, 10.9),

            ],

            isCurved: true,
            color: Colors.red,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: false,
            ),
            // belowBarData: BarAreaData(
            //   show: true,
            //   color: Colors.blue,
            // ),
          ),
        ],
      );
    }

    LineChartData avgChart() {
      return LineChartData(
        lineTouchData: LineTouchData(enabled: false),
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: const Color(0xff37434d),
              strokeWidth: 1,
            );
          },
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: const Color(0xff37434d),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          //오른쪽 0 50 100 150 지우기
          rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              )
          ),

          //위쪽 0 50 100 150 지우기
          topTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              )
          ),
          // bottomTitles: SideTitles(
          //   showTitles: true,
          //   reservedSize: 22,
          //   textStyle: const TextStyle(
          //       color: Color(0xff68737d),
          //       fontWeight: FontWeight.bold,
          //       fontSize: 16),
          //   getTitles: (value) {
          //     switch (value.toInt()) {
          //       case 2:
          //         return 'MAR';
          //       case 5:
          //         return 'JUN';
          //       case 8:
          //         return 'SEP';
          //     }
          //     return '';
          //   },
          //   margin: 8,
          // ),
          // leftTitles: SideTitles(
          //   showTitles: true,
          //   textStyle: const TextStyle(
          //     color: Color(0xff67727d),
          //     fontWeight: FontWeight.bold,
          //     fontSize: 15,
          //   ),
          //   getTitles: (value) {
          //     switch (value.toInt()) {
          //       case 1:
          //         return '10k';
          //       case 3:
          //         return '30k';
          //       case 5:
          //         return '50k';
          //     }
          //     return '';
          //   },
          //   reservedSize: 28,
          //   margin: 12,
          // ),
        ),
        borderData: FlBorderData(
            show: true,
            border: Border.all(color: const Color(0xff37434d), width: 1)),
        minX: 6,
        maxX: 24,
        minY: 0,
        maxY: 200,

        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(6, 40),
              FlSpot(24, 40),
            ],
            isCurved: true,
            // colors: [
            //   ColorTween(begin: gradientColors[0], end: gradientColors[1])
            //       .lerp(0.2),
            //   ColorTween(begin: gradientColors[0], end: gradientColors[1])
            //       .lerp(0.2),
            // ],
            barWidth: 5,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: false,
            ),
            belowBarData: BarAreaData(show: true,
              //     colors: [
              //   ColorTween(begin: gradientColors[0], end: gradientColors[1])
              //       .lerp(0.2)
              //       .withOpacity(0.1),
              //   ColorTween(begin: gradientColors[0], end: gradientColors[1])
              //       .lerp(0.2)
              //       .withOpacity(0.1),
              // ]
            ),
          ),
        ],
      );
    }


  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 6:
        text = '6';
        break;
      case 8:
        text = '8';
        break;
      case 10:
        text = '10';
        break;
      case 12:
        text = '12';
        break;
      case 14:
        text = '14';
        break;
      case 16:
        text = '16';
        break;
      case 18:
        text = '18';
        break;
      case 20:
        text = '20';
        break;
      case 22:
        text = '22';
        break;
      case 24:
        text = '24';
        break;

      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          // color: mainLineColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.red,
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 50:
        text = '50';
        break;
      case 100:
        text = '100';
        break;
      case 150:
        text = '150';
        break;
      case 200:
        text = '200';
        break;

      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          // color: mainLineColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

  }


}
