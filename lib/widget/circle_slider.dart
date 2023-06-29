import 'package:flutter/material.dart';
import 'package:subway_congestion/screen/detail_screen.dart';

class CircleList extends StatelessWidget {
  final List<String> subWayList;
  const CircleList({super.key, required this.subWayList});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: makeCircleImages(context, subWayList),
    );
  }
}

List<Widget> makeCircleImages(BuildContext context, List<String> list) {
  List<Widget> results = [];
  for (var i = 0; i < list.length; i++) {
    results.add(
      InkWell(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute<Null>(
              fullscreenDialog: true,
              builder: (BuildContext content){
                return DetailScreen(
                  subwayName: list[i],
                  direction1: ((i - 1) >= 0) ? list[i - 1] : 'None',
                  direction2: ((i + 1) < list.length) ? list[i + 1] : 'None',
                );
              }
          ));
        },
        child: Row(
          children: [
            Container(
              //아니 왜 크기가 큰지 모르겠어요,,AspectRatio이걸로 하니깐
              //작아지긴했는데 왜인지는 모르겠어. 아래 color는 임시 디버깅용.
              // color: Colors.amber,
              child: Column(
                children: [
                  Text(list[i]),
                  SizedBox(height: 10),
                  CustomPaint(
                    size: Size(30, 30),
                    painter: CirclePainter(
                        textSize: list[i].length,
                        nextTextSize: ((i + 1) != list.length) ? list[i + 1].length : -1),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
  return results;
}

class CirclePainter extends CustomPainter {

  final int textSize;
  final int nextTextSize;
  CirclePainter({required this.textSize, required this.nextTextSize});

  @override
  void paint(Canvas canvas, Size size) {
    final circlePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Color.fromRGBO(84, 162, 154, 1)
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;

    final linePaint = Paint()
      ..color = Color.fromRGBO(84, 162, 154, 1)
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke;

    int plus = 0;

    if(nextTextSize == -1){
      plus = 0;
    }
    else if(textSize > nextTextSize){
      plus = textSize;
    } else{
      plus = nextTextSize;
    }

    // 선 그리기 (시작점과 끝점을 원에 맞게 조정하고, 간격을 조금 띄웁니다.)
    canvas.drawLine(
      Offset(size.width + (plus * 10), size.height / 2),
      Offset(size.width, size.height / 2),
      linePaint,);

    // 원 그리기
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2, circlePaint);

    // 원 테두리 그리기
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

