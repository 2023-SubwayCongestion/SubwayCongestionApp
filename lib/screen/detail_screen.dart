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
    'items': [1,0,2,1,0],
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


  Future<List<DocumentSnapshot>> getCongestionRealTimeTrain(int i) async {
    print("getCongestionRealTimeTrain start");
    print(widget.subwayName);
    print(widget.direction1);
    print(widget.direction2);


    List<DocumentSnapshot> documents = [];



    QuerySnapshot snapshot = await widget.firestore
        .collection('realTimeTrain')
        .where('hocha', isEqualTo: i)
        .where('source', isEqualTo: widget.subwayName.substring( //source가 사용자가 클릭한 역
        0, widget.subwayName.length - 1))
        .where('destination', isEqualTo: widget.direction2.substring( //destination이 그냥 혜화역 방면인거로 fix
        0, widget.direction2.length - 1))
        .get();


    //더미데이터 삭제하기. 1회만 실행되면 됨. 실행 후 이 코드는 제거
    // QuerySnapshot s= await firestore.collection('realTimeTrain').where('destination', isEqualTo: "test").get();
    // for (var doc in s.docs) {
    //   var documentId = doc.id;
    //   print('Document ID: $documentId');
    //   await firestore.collection('realTimeTrain').doc(documentId).delete();
    // }


    documents = snapshot.docs;




    print(documents.toString());
    print("getCongestionRealTimeTrain end");
    return documents;
  }

  Future<void> fetchData() async {
    var conges=[0,0,0,0,0];
    DateTime currentTime = DateTime.now();
    for(int i=0;i<5;i++){
      List<DocumentSnapshot> realTimeTrain = await getCongestionRealTimeTrain(i+1);
      

      int nearestIndex = findNearestTimestampIndex(currentTime, realTimeTrain);
      DateTime nearestDateTime;
      Map<String, dynamic> nearestData = realTimeTrain[nearestIndex].data() as Map<String, dynamic>;
      if(nearestData['date'] is Timestamp){
        Timestamp nearestTimestamp = nearestData['date'];
        nearestDateTime = nearestTimestamp.toDate();
      }else{
        String str=nearestData['date'];
        nearestDateTime = DateTime.parse(str);
      }


      String nearestCongestion=nearestData['congestion'];

      print('Nearest congestion: $nearestCongestion');
      if(nearestCongestion=="여유"){
        conges[i]=0;
      }else if(nearestCongestion=="보통"){
        conges[i]=1;
      }else{
        conges[i]=2;
      }
      // print('Nearest Index: $nearestIndex');
      print('Nearest Timestamp: $nearestDateTime');
      print('Nearest Data: $nearestData');
      
    }
    
    
    
    realTimeinfo1 = Congestion.fromMap({
      'lastDest': '충무로행',
      'time': '12:50',
      'items': [0,1,0,2,1],
    });

    realTimeinfo2 = Congestion.fromMap({
      'lastDest': '미아행',
      'time': '12:50',
      'items': [conges[0],conges[1],conges[2],conges[3],conges[4]],
    });
    setState(() {

    });




    
  }

  int findNearestTimestampIndex(DateTime currentTime, List<DocumentSnapshot> snapshots) {
    int nearestIndex = 0;
    int minDifference = 9223372036854775807;

    for (int i = 0; i < snapshots.length; i++) {
      Map<String, dynamic> data = snapshots[i].data() as Map<String, dynamic>;
      DateTime dateTime;

      if(data['date'] is Timestamp){
        Timestamp timestamp = data['date'];
        dateTime=timestamp.toDate();
      }else{
        String dateString=data['date'];
        dateTime = DateTime.parse(dateString);
      }





      int difference = (dateTime.millisecondsSinceEpoch - currentTime.millisecondsSinceEpoch).abs();

      if (difference < minDifference) {
        minDifference = difference;
        nearestIndex = i;
      }
    }

    // print("neareastIndex value : " + nearestIndex.toString());
    return nearestIndex;
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
