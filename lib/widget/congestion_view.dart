import 'package:flutter/material.dart';
import 'package:subway_congestion/model/model_congestion.dart';

class CongestionView extends StatelessWidget {
  final Congestion info;

  const CongestionView({
    super.key,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('     ' + info.lastDest + ' ' + info.time),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: makeCongeInfo(info.items),
          ),
        ],
      ),
    );
  }
}

List<Widget> makeCongeInfo(List<int> list){
  List<Widget> results = [];
  for (var i = 0; i < list.length; i++) {
    Color bgColor = Colors.black;

    if(list[i] == 0) bgColor = Color.fromRGBO(140, 190, 112, 1);
    else if(list[i] == 1) bgColor = Color.fromRGBO(255, 233, 0, 1);
    else bgColor = Color.fromRGBO(255, 116, 116, 1);

    results.add(
      Container(
        width: 50,
        height: 50,
        color: bgColor,
        child: Center(
          child: Text('${i +1}', style: TextStyle(
            color: Colors.white,
            fontSize: 35,
            fontWeight: FontWeight.bold,),
          ),
        ),
      ),
    );
  }
  return results;
}