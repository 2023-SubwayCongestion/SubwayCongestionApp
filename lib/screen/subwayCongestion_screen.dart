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
}