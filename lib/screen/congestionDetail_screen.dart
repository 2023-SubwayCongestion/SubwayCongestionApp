import 'package:flutter/material.dart';
import 'package:subway_congestion/header.dart';
import 'package:subway_congestion/model/model_congestion.dart';
import 'package:subway_congestion/widget/congestion_view.dart';
import 'package:subway_congestion/widget/custom_button.dart';

class CongestionDetailScreen extends StatefulWidget {
  final String subwayName;
  final String direction1;
  final String direction2;

  const CongestionDetailScreen({
    super.key,
    required this.subwayName,
    required this.direction1,
    required this.direction2,
  });

  @override
  State<CongestionDetailScreen> createState() => _CongestionDetailScreenState();
}

class _CongestionDetailScreenState extends State<CongestionDetailScreen> {
  int _selectedWidgetIndex = 0;

  Congestion realTimeinfo1 = Congestion.fromMap({
    'lastDest': '사당행',
    'time': '12:50',
    'items': [0,1,0,2,1],
  });

  Congestion realTimeinfo2 = Congestion.fromMap({
    'lastDest': '진접행',
    'time': '12:50',
    'items': [1,2,0,1,2],
  });


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: getColor('main2'),
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
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
            widget.subwayName + ' 시간대별 혼잡도 통계',
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
              height: 10,
            ),
            Text('hi'),
            SizedBox(
              height: 30,
            ),

          ],
        ),
      ),
    );
  }
}
