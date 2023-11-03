import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subway_congestion/widget/circle_slider.dart';

import '../services/firebase_auth_methods.dart';
import '../widget/myMenu.dart';

class SubwayLine extends StatefulWidget {
  const SubwayLine({super.key});

  @override
  State<SubwayLine> createState() => _SubwayLineState();
}

class _SubwayLineState extends State<SubwayLine> {
  List<String> SubwayList1 = [
    '증산역',
    '디지털미디어시티역',
    '월드컵경기장역',
    '마포구청역',
    '망원역',
    '합정역',
    '상수역',
    '광흥창역',
    '대흥역',
    '공덕역',
  ];

  List<String> SubwayList2 = [
    '연신내역',
    '불광역',
    '녹번역',
    '홍제역',
    '무악재역',
    '독립문역',
    '경복궁역',
    '안국역',
    '종로3가역',

  ];
  List<String> SubwayList3 = [
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
  List<String> SubwayList4 = [
    '홍대입구역',
    '신촌역',
    '이대역',
    '아현역',
    '충정로역',
    '시청역',
    '을지로입구역',
    '을지로3가역',
    '을지로4가역',
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

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                AspectRatio(
                  aspectRatio:2.7,
                  child:
                  CircleList(
                      subWayList: SubwayList1,
                    color1: Color.fromRGBO(160, 120, 0, 1),
                  ),
                ),
                AspectRatio(
                  aspectRatio:2.7,
                  child:
                  CircleList(
                      subWayList: SubwayList2,color1: Color.fromRGBO(255, 170, 0, 1),),
                ),
                AspectRatio(
                  aspectRatio:2.7,
                  child:
                  CircleList(
                      subWayList: SubwayList3,color1: Color.fromRGBO(84, 162, 154, 1)),
                ),
                AspectRatio(
                  aspectRatio:2.7,
                  child:
                  CircleList(
                      subWayList: SubwayList4,color1: Color.fromRGBO(3, 152, 53, 1),),
                ),
              ],
            ),




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
      drawer: myMenu(),




    );
  }
}
