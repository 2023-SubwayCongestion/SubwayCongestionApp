import 'package:flutter/material.dart';
import 'package:subway_congestion/header.dart';
import 'package:subway_congestion/model/model_congestion.dart';
import 'package:subway_congestion/widget/congestion_view.dart';
import 'package:subway_congestion/widget/custom_button.dart';

class DetailScreen extends StatefulWidget {
  final String subwayName;
  final String direction1;
  final String direction2;

  const DetailScreen({
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
        return Text('첫 번째 위젯');
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
                                setState(() { _selectedWidgetIndex = 0;});
                                },
                              child: Text(
                                "● ${widget.direction1}", style: TextStyle(
                                  color: getColor((_selectedWidgetIndex == 0) ? 'main1' : 'grey'), fontSize: 20
                                ),
                              )
                          ),

                          TextButton(
                              onPressed: () {
                                setState(() { _selectedWidgetIndex = 1;});
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
