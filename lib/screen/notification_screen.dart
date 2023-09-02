import 'package:flutter/material.dart';
import 'package:subway_congestion/header.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final Stream<QuerySnapshot> _notificationsStream = FirebaseFirestore.instance.collection('notifications').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColor('main2'),
      appBar: AppBar(
        title: Text(
          'NOTIFICATION',
          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1),),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(84, 162, 154, 1),
      ),
      body: Center(
        child:
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: StreamBuilder<QuerySnapshot>(
            stream:_notificationsStream,
            builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                  String title = data['title'];
                  String body = data['body'];
                  String timestamp = data['timestamp'];

                  return Container(
                      width: MediaQuery.of(context).size.width * 0.8, // 화면 너비의 80%
                  height: MediaQuery.of(context).size.height * 0.12 + title.length*0.7+ body.length*0.5, // 화면 높이의 20%
                  child: Card(
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // card의 둥근 모서리 정도 설정
                  ),
                  color: Colors.white,
                  child: ListTile(
                  contentPadding: EdgeInsets.all(10),
                  title : Text(title),
                  subtitle : Text( body + "\n\n" + timestamp),
                  isThreeLine : true,
                  ),
                  ),
                  );
                  }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
