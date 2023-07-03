import 'package:flutter/material.dart';
import 'package:flutter_donation_buttons/flutter_donation_buttons.dart';
import 'package:provider/provider.dart';
import '../services/firebase_auth_methods.dart';
import '../utils/category.dart';
import '../widget/custom_button.dart';
import '../widget/custom_image.dart';
import 'home_screen.dart';


class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);


  @override
  _ReportPage createState() => _ReportPage();
}

class _ReportPage extends State<ReportPage> {

  @override
  Widget build(BuildContext context) {
    final user = context
        .read<FirebaseAuthMethods>()
        .user;
    return Scaffold(
        backgroundColor: Colors.white,
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
                // key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const Text(
                      //   '지하철역',
                      //   style: TextStyle(
                      //     letterSpacing: 1.0,
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 15,
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 0.0),
                      //   child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Container(
                      //           width:
                      //           MediaQuery.of(context).size.width / 1.1,
                      //           child: DropdownButtonFormField(
                      //             hint: Text('상위 카테고리를 선택해주세요',
                      //                 style: TextStyle(
                      //                     color: Colors.black, fontSize: 17)),
                      //             isExpanded: true,
                      //             alignment: Alignment.center,
                      //             items: upperCategoryList.map((value) {
                      //               return DropdownMenuItem(
                      //                 value: value,
                      //                 child: Center(
                      //                   child: Text(
                      //                     value,
                      //                     textAlign: TextAlign.center,
                      //                   ),
                      //                 ),
                      //               );
                      //             }).toList(),
                      //             onChanged: (String? value) {
                      //               // setState(() {
                      //               //   selectedUpper = value!;
                      //               //   post.upperCategory = value;
                      //               //   lowerCategoryList =
                      //               //       setLowerCategory(value!.toString());
                      //               //   selectedLower = lowerCategoryList[0];
                      //               // });
                      //             },
                      //             onSaved: (value) {
                      //               // selectedUpper = value!.toString();
                      //               // post.upperCategory = value;
                      //               // lowerCategoryList =
                      //               //     setLowerCategory(value!.toString());
                      //             },
                      //             value: selectedUpper == null
                      //                 ? null
                      //                 : selectedUpper,
                      //           ),
                      //         ),
                      //       ]),
                      // ),
                      // const SizedBox(
                      //   height: 20.0,
                      //   width: 600,
                      // ),

                      // 하위 카테고리 //
                      // const Text(
                      //   '지하철 방면',
                      //   style: TextStyle(
                      //     letterSpacing: 1.0,
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 15,
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 20.0),
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Container(
                      //         width:
                      //         MediaQuery.of(context).size.width / 1.1,
                      //         child: DropdownButtonFormField(
                      //           hint: Text('하위 카테고리를 선택해주세요',
                      //               style: TextStyle(
                      //                   color: Colors.black, fontSize: 17)),
                      //           isExpanded: true,
                      //           alignment: Alignment.center,
                      //           items: upperCategoryList.map((value) {
                      //             return DropdownMenuItem(
                      //               value: value,
                      //               child: Center(
                      //                 child: Text(
                      //                   value,
                      //                   textAlign: TextAlign.center,
                      //                 ),
                      //               ),
                      //             );
                      //           }).toList(),
                      //           onChanged: (String? value) {
                      //             // setState(() {
                      //             //   selectedUpper = value!;
                      //             //   post.upperCategory = value;
                      //             //   lowerCategoryList =
                      //             //       setLowerCategory(value!.toString());
                      //             //   selectedLower = lowerCategoryList[0];
                      //             // });
                      //           },
                      //           onSaved: (value) {
                      //             // selectedUpper = value!.toString();
                      //             // post.upperCategory = value;
                      //             // lowerCategoryList =
                      //             //     setLowerCategory(value!.toString());
                      //           },
                      //           value: selectedUpper == null
                      //               ? null
                      //               : selectedUpper,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 20.0,
                      // ),

                      // 제목 //
                      const Text(
                        '제목',
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
                          // onChanged: (text) {
                          //   post.title = text;
                          // },
                          // onSaved: (text) {
                          //   post.title = text;
                          // },
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
                              )),
                          // onChanged: (text) {
                          //   post.content = text;
                          // },
                          // onSaved: (text) {
                          //   post.content = text;
                          // },
                          autofocus: true,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),

                      // 인원 //

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 50),
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const HomeScreen()),
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
                              onPressed: () {
                                // showPopup(context);
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
                    ]),
              ),
            ]
        )
    );
  }
}