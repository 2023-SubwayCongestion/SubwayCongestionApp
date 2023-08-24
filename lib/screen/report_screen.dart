import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subway_congestion/header.dart';
import '../services/firebase_auth_methods.dart';
import '../widget/bottom_bar.dart';
import 'home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // For formatting timestamp



class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);


  @override
  _ReportPage createState() => _ReportPage();
}

class _ReportPage extends State<ReportPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Add this line

  String title = '1'; // Declare these variables
  String content = '2';
  String selectedStation = '3';
  String selectedDirection = '4';
  final firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final user = context
        .read<FirebaseAuthMethods>()
        .user;

    return Scaffold(
        backgroundColor: getColor('main2'),
        appBar: AppBar(
          title: Text(
            'REPORT',
            style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1),),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Color.fromRGBO(84, 162, 154, 1),
        ),
        drawer: Drawer(
          // 앱바 왼편에 햄버거 버튼 생성
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/logo.png'),
                  backgroundColor: Colors.white,
                ),
                // otherAccountsPictures: [
                //   CircleAvatar(
                //     // backgroundImage: AssetImage('assets/github.png'),
                //     backgroundColor: Colors.white,
                //   )
                // ],
                accountName: Text('멋진쟃빛박쥐#0011'),
                accountEmail: Text(user.email!),
                onDetailsPressed: () {
                  print('arrow is clicked');
                },
                decoration: BoxDecoration(
                    color: Color.fromRGBO(84, 162, 154, 1),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0))),
              ),
              ListTile(
                leading: Icon(Icons.location_on, color: Colors.grey[850]),
                title: Text('위치'),
                onTap: () {
                  print('Home is clicked');
                },
                trailing: Icon(Icons.add),
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.grey[850]),
                title: Text('설정'),
                onTap: () {
                  print('Setting is clicked');
                },
                trailing: Icon(Icons.add),
              ),
              ListTile(
                leading: Icon(Icons.campaign, color: Colors.grey[850]),
                title: Text('공지사항'),
                onTap: () {
                  print('Q&A is clicked');
                },
                trailing: Icon(Icons.add),
              ),
            ],
          ),
        ),
        body: ListView(
            padding: const EdgeInsets.fromLTRB(20.0, 40.0, 0.0, 0.0),
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 제목 //
                    const Text(
                      '신고 제목',
                      style: TextStyle(
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: TextFormField(
                        key: ValueKey(1),
                        onSaved: (value) {
                          title = value ?? '';
                        },
                        onChanged: (value) {
                          setState(() {
                            title = value ?? '';
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '제목을 입력해주세요!';
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: '제목을 입력해주세요.',
                        ),
                        autofocus: true,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),

                    // 내용 //
                    const Text(
                      '내용',
                      style: TextStyle(
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      height: 10 * 24.0,
                      padding: const EdgeInsets.only(right: 15),
                      child: TextFormField(
                        key: ValueKey(2),
                        onSaved: (value) {
                          content = value ?? '';
                        },
                        onChanged: (value) {
                          setState(() {
                            content = value ?? '';
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '내용을 입력해주세요!';
                          } else {
                            return null;
                          }
                        },
                        maxLines: 10,
                        decoration: const InputDecoration(
                          hintText: '내용을 입력해주세요.',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        autofocus: true,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),

                    // 드롭다운 박스 //
                    const Text(
                      '역 선택',
                      style: TextStyle(
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: DropdownButtonFormField<String>(
                        key: ValueKey(3),
                        onSaved: (value) {
                          selectedStation = value ?? '';
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '역을 선택해주세요!';
                          } else {
                            return null;
                          }
                        },
                        items: ['충무로', '동대문역사문화공원','동대문','혜화','한성대입구','성신여대입구','길음','미아사거리','미아'].map((String station) {
                          return DropdownMenuItem<String>(
                            value: station,
                            child: Text(station),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedStation = newValue ?? '';
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: '역을 선택해주세요.',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    // 드롭다운 박스 (방면 선택) //
                    const Text(
                      '방면 선택',
                      style: TextStyle(
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: DropdownButtonFormField<String>(
                        key: ValueKey(4),
                        onSaved: (value) {
                          selectedDirection = value ?? '';
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '방면을 선택해주세요!';
                          } else {
                            return null;
                          }
                        },
                        items: ['미아행', '충무로행'].map((String direction) {
                          return DropdownMenuItem<String>(
                            value: direction,
                            child: Text(direction),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedDirection = newValue ?? '';
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: '방면을 선택해주세요.',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 50),
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ReportPage()),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                            child: const Text(
                              '초기화하기',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 50.0,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 50),
                          child: OutlinedButton(
                            onPressed: () async {
                              print("start!!");
                              if (_formKey.currentState!.validate()) {
                                String currentTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

                                try {
                                  await firestore.collection('personalReport').add({
                                    'title': title,
                                    'content': content,
                                    'station': selectedStation,
                                    'direction': selectedDirection,
                                    'timestamp': currentTime,
                                    'read':0,
                                  });

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const HomeScreen()),

                                  );
                                } catch (error) {
                                  print('Error saving data: $error');
                                }

                              }
                              print("end!!");
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: const Color(0xff686EFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                            child: const Text(
                              '제출하기',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),


                      ],
                    )
                  ],
                ),
              ),

            ]
        ),
        // bottomNavigationBar: BottomBar(0, 0),
    );
  }
}



