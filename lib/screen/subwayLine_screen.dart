import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subway_congestion/widget/circle_slider.dart';

import '../services/firebase_auth_methods.dart';

class SubwayLine extends StatefulWidget {
  const SubwayLine({super.key});

  @override
  State<SubwayLine> createState() => _SubwayLineState();
}

class _SubwayLineState extends State<SubwayLine> {
  List<String> SubwayList = [
    '충무로역',
    '동대문역사문화공원역',
    '동대문역',
    '혜화역',
    '한성대입구역',
    '성신여대입구역',
    '길음역',
    '미아사거리역',
    '미아역',
  ];

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            color: Color.fromRGBO(245, 243, 228, 1),
          ),
      Center(
        child: AspectRatio(
            aspectRatio:5.0,
            child: CircleList(
                subWayList: SubwayList)
        )),
        ],

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
