import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:subway_congestion/header.dart';
import 'package:subway_congestion/model/model_congestion.dart';
import 'package:subway_congestion/widget/congestion_view.dart';
import 'package:subway_congestion/widget/custom_button.dart';

import 'congestionDetail_screen.dart';

class DetailScreen extends StatefulWidget {
  final String subwayName;
  final String direction1;
  final String direction2;
  final firestore = FirebaseFirestore.instance;

  DetailScreen({
    super.key,
    required this.subwayName,
    required this.direction1,
    required this.direction2,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _selectedWidgetIndex = 0;
  final firestore = FirebaseFirestore.instance;

  Congestion realTimeinfo1 = Congestion.fromMap({
    'lastDest': '충무로행',
    'time': '12:50',
    'items': [0,1,0,2,1],
  });

  Congestion realTimeinfo2 = Congestion.fromMap({
    'lastDest': '미아행',
    'time': '12:50',
    'items': [1,2,0,1,2],
  });



  //여기 아이템즈 부분에 12012에 가운데 0을 realtimeTrain정보에 따라 알잘딱깔센 바꿔야 함.
  //


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.direction1 == 'None'){
      _selectedWidgetIndex = 1;
    }fetchData();
  }
  // Future<void> fetchData() async {
  //   // print("fetchData start");
  //   List<DocumentSnapshot> realTimeTrain = await getCongestionRealTimeTrain();
  //   for(int i=0;i<realTimeTrain.length;i++){
  //     Map<String, dynamic> data = realTimeTrain[i].data() as Map<String, dynamic>;
  //
  //   }
  //
  //   print("ok");
  // }
  Future<void> fetchData() async {
    List<DocumentSnapshot> realTimeTrain = await getCongestionRealTimeTrain();
    int conges=0;
    DateTime currentTime = DateTime.now();
    int nearestIndex = findNearestTimestampIndex(currentTime, realTimeTrain);

    Map<String, dynamic> nearestData = realTimeTrain[nearestIndex].data() as Map<String, dynamic>;
    Timestamp nearestTimestamp = nearestData['date'];
    DateTime nearestDateTime = nearestTimestamp.toDate();

    String nearestCongestion=nearestData['congestion'];

    print('Nearest congestion: $nearestCongestion');
    if(nearestCongestion=="여유"){
      conges=0;
    }else if(nearestCongestion=="보통"){
      conges=1;
    }else{
      conges=2;
    }
    print('Nearest Index: $nearestIndex');
    print('Nearest Timestamp: $nearestDateTime');
    print('Nearest Data: $nearestData');

    realTimeinfo1 = Congestion.fromMap({
      'lastDest': '충무로행',
      'time': '12:50',
      'items': [0,1,0,2,1],
    });

    realTimeinfo2 = Congestion.fromMap({
      'lastDest': '미아행',
      'time': '12:50',
      'items': [1,2,conges,1,2],
    });
    setState(() {

    });
  }

  int findNearestTimestampIndex(DateTime currentTime, List<DocumentSnapshot> snapshots) {
    int nearestIndex = 0;
    int minDifference = 9223372036854775807;

    for (int i = 0; i < snapshots.length; i++) {
      Map<String, dynamic> data = snapshots[i].data() as Map<String, dynamic>;
      Timestamp timestamp = data['date'];
      DateTime dateTime = timestamp.toDate();

      int difference = (dateTime.millisecondsSinceEpoch - currentTime.millisecondsSinceEpoch).abs();

      if (difference < minDifference) {
        minDifference = difference;
        nearestIndex = i;
      }
    }

    // print("neareastIndex value : " + nearestIndex.toString());
    return nearestIndex;
  }


  Future<List<DocumentSnapshot>> getCongestionRealTimeTrain() async {
    print("getCongestionRealTimeTrain start");
    print(widget.subwayName);
    print(widget.direction1);
    print(widget.direction2);


    List<DocumentSnapshot> documents = [];

      QuerySnapshot snapshot = await widget.firestore
          .collection('realTimeTrain')
          .where('hocha', isEqualTo: 3) //3호차만 기준으로 하기로 했으니까 3으로 걍 넣어줌.
          .where('source', isEqualTo: widget.subwayName.substring(
          0, widget.subwayName.length - 1))
          .get();
      documents = snapshot.docs;

    print(documents.toString());
    print("getCongestionRealTimeTrain end");
    return documents;
  }

  // 두 위젯 중 하나를 반환하는 메서드
  Widget _getDisplayWidget() {
    switch (_selectedWidgetIndex) {
      case 0:
        // return Text('첫 번째 위젯');
        return CongestionView(info: realTimeinfo1,);
      case 1:
        // return Text('두 번째 위젯');
        return CongestionView(info: realTimeinfo2,);
      default:
        return Text('다른 방면 선택해주세요!');
    }
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
            widget.subwayName + ' 혼잡도',
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
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.7,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(20), // 원하는 둥근 모서리의 크기를 설정합니다.
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  if(widget.direction1 == 'None')  _selectedWidgetIndex = -1;
                                  else _selectedWidgetIndex = 0;
                                });
                                },
                              child: Text(
                                "● ${widget.direction1}", style: TextStyle(
                                  color: getColor((_selectedWidgetIndex == 0) ? 'main1' : 'grey'), fontSize: 20
                                ),
                              )
                          ),

                          TextButton(
                              onPressed: () {
                                setState(() {
                                  if(widget.direction2 == 'None')  _selectedWidgetIndex = -1;
                                  else _selectedWidgetIndex = 1;
                                });
                              },
                              child: Text(
                                "● ${widget.direction2}", style: TextStyle(
                                color: getColor((_selectedWidgetIndex == 1) ? 'main1' : 'grey'), fontSize: 20
                              ),
                              )
                          ),
                        ],
                      ),
                      SizedBox(height: 50,),
                      _getDisplayWidget(),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            CustomButton(
                onTap: (){
                  // Navigator.of(context).push(MaterialPageRoute<Null>(
                  //     fullscreenDialog: true,
                  //     builder: (BuildContext content){
                  //       return DetailScreen(subwayName: widget.subwayName,);
                  //     }
                  // ));
                  Navigator.of(context).push(MaterialPageRoute<Null>(
                      fullscreenDialog: true,
                      builder: (BuildContext content){
                        return CongestionDetailScreen(
                          subwayName: widget.subwayName,
                          direction1: _selectedWidgetIndex.toString(),
                          direction2: _selectedWidgetIndex.toString(),
                        );

                      }
                  ));
                },
                text: widget.subwayName + ' 혼잡도 보기',
                bg_color: Color.fromRGBO(84, 162, 154, 1),
                tx_color: Colors.white),
          ],
        ),
      ),
    );
  }
}
