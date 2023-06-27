import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/firebase_auth_methods.dart';
import '../widget/custom_button.dart';



class SubwayStationPage extends StatefulWidget {
  const SubwayStationPage({Key? key}) : super(key: key);

  @override
  _SubwayStationPage createState() => _SubwayStationPage();
}



class _SubwayStationPage extends State<SubwayStationPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
// 1시에 호출함
//     <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
//       <realtimeStationArrival><RESULT><code>INFO-000</code>
//         <developerMessage></developerMessage><link></link><message>정상 처리되었습니다.</message>
//
//     <status>200</status><total>1</total></RESULT><row><rowNum>1</rowNum><selectedCount>1</selectedCount><totalCount>1</totalCount>
//
//     <subwayId>1003</subwayId>
//     <updnLine>상행</updnLine>
//     <trainLineNm>대화행 - 대화방면 (막차)</trainLineNm>
//     <statnFid>1003000310</statnFid>
//     <statnTid>1003000309</statnTid>
//     <statnId>1003000309</statnId>
//     <statnNm>대화</statnNm>
//     <trnsitCo>1</trnsitCo>
//     <ordkey>01000대화0</ordkey>
//     <subwayList>1003</subwayList>
//     <statnList>1003000309</statnList>
//     <btrainSttus>일반</btrainSttus>
//     <barvlDt>0</barvlDt>
//     <btrainNo>3422</btrainNo>
//     <bstatnId>152</bstatnId>
//     <bstatnNm>대화 (막차)</bstatnNm>
//     <recptnDt>2023-06-27 00:42:15</recptnDt>
//     <arvlMsg2>대화 도착</arvlMsg2>
//     <arvlMsg3>대화</arvlMsg3>
//     <arvlCd>1</arvlCd>
//
//     </row></realtimeStationArrival>
//     655944544e706b673735697674416c
//
//     활용사례 갤러리 하면 되니까 ok
//     6a6246564a706b673536454174584d
//     http://swopenAPI.seoul.go.kr/api/subway/6a6246564a706b673536454174584d/xml/realtimeStationArrival/0/5/서울
//
//     http://swopenAPI.seoul.go.kr/api/subway/655944544e706b673735697674416c/xml/realtimeStationArrival/ALL/0/1

    );
  }

}
