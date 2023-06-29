import 'package:flutter/material.dart';
import 'package:subway_congestion/widget/circle_slider.dart';

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
    '성신여대역',
    '길음역',
    '미아사거리역',
    '미아역',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            color: Color.fromRGBO(245, 243, 228, 1),
          ),
          TopBar(),
          Center(
              child: AspectRatio(
                  aspectRatio:5.0,
                  child: CircleList(
                      subWayList: SubwayList)
              )
          ),
        ],
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.line_weight,
                color: Color.fromRGBO(84, 162, 154, 1),
              )),
          Text(
            'MAP',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(84, 162, 154, 1)),
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.line_weight,
                color: Color.fromRGBO(84, 162, 154, 1),
              )),
        ],
      ),
    );
  }
}
