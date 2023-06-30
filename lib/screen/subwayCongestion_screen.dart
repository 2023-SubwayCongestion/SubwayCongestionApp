import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subway_congestion/screen/detail_screen.dart';
import 'package:subway_congestion/widget/circle_slider.dart';
import 'package:subway_congestion/widget/congestion_view.dart';

import '../services/firebase_auth_methods.dart';
import '../widget/custom_button.dart';
import 'congestionDetail_screen.dart';

class SubwayCongestion extends StatefulWidget {
  const SubwayCongestion({super.key});

  @override
  State<SubwayCongestion> createState() => _SubwayCongestionState();
}

class _SubwayCongestionState extends State<SubwayCongestion> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];bool showAvg = false;
  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Align(
              alignment: Alignment.center,
              child: Container(
                  // margin: ,
                  child: CustomButton(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute<Null>(
                          fullscreenDialog: true,
                          builder: (BuildContext content){
                            return CongestionDetailScreen(
                              subwayName: '충무로역',
                              direction1: 'None',
                              direction2: 'None',
                            );
                          }
                      ));
                    },
                    text: '혼잡도 버튼',bg_color: Color.fromRGBO(0, 0, 0, 1),tx_color: Color.fromRGBO(255, 255, 255, 1),
                  ),

              )
          ),

        SafeArea(
          child: Column(
            children: <Widget>[
              TextButton(
                child: Text(
                  showAvg ? '평균값 O' : '평균값 X',
                  style: TextStyle(
                      color:
                      showAvg ? Colors.white.withOpacity(0.5) : Colors.white),
                ),
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
                      color: Color(0xff232d37)),
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


          //chart 넣어야 함. 시간대별 평균 혼잡도 차트 + 현재 혼잡도는? 몇.  현재역과 시간값만 가져오면 됨.

        ]
      ),









      appBar: AppBar(
        title: Text(
          'MAP',
          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1),),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(84, 162, 154, 1),
      ),
      drawer: Drawer(
        // 앱바 왼편에 햄버거 버튼 생성
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/logo.png'),
                backgroundColor: Colors.white,
              ),
              // otherAccountsPictures: [
              //   CircleAvatar(
              //     // backgroundImage: AssetImage('assets/github.png'),
              //     backgroundColor: Colors.white,
              //   )
              // ],
              accountName: Text('멋진쟃빛박쥐#0011'),
              accountEmail: Text(user.email!),
              onDetailsPressed: () {
                print('arrow is clicked');
              },
              decoration: BoxDecoration(
                  color: Color.fromRGBO(84, 162, 154, 1),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0))),
            ),
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.grey[850]),
              title: Text('위치'),
              onTap: () {
                print('Home is clicked');
              },
              trailing: Icon(Icons.add),
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.grey[850]),
              title: Text('설정'),
              onTap: () {
                print('Setting is clicked');
              },
              trailing: Icon(Icons.add),
            ),
            ListTile(
              leading: Icon(Icons.campaign, color: Colors.grey[850]),
              title: Text('공지사항'),
              onTap: () {
                print('Q&A is clicked');
              },
              trailing: Icon(Icons.add),
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
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        // bottomTitles: SideTitles(
        //   showTitles: true,
        //   reservedSize: 22,
        //   textStyle: const TextStyle(
        //       color: Color(0xff68737d),
        //       fontWeight: FontWeight.bold,
        //       fontSize: 16),
        //   getTitles: (value) {
        //     print('bottomTitles $value');
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
        //     print('leftTitles $value');
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
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          color: Colors.red,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            color: Colors.blue,
          ),
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
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
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
}