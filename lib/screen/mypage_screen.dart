import 'package:flutter/material.dart';
import 'package:flutter_donation_buttons/flutter_donation_buttons.dart';
import 'package:provider/provider.dart';
import '../services/firebase_auth_methods.dart';
import '../widget/custom_button.dart';
import '../widget/custom_image.dart';
import 'home_screen.dart';


class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);


  @override
  _UserPage createState() => _UserPage();
}

class _UserPage extends State<UserPage> {



  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;
    return Scaffold(

      appBar: AppBar(
        title: Text(
          'MAP',
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




      body: Stack(

        // alignment: Alignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            child: Table(
              // border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Text(''),
                    ),
                    TableCell(
                      child: Text('<app develop>'),
                    ),
                    TableCell(
                      child: Text(''),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: CustomImage(
                        filename: 'assets/pmg1212.png',
                        widthPercent: 0.4,
                        heightPercent: 0.2,
                      ),
                    ),
                    TableCell(
                      child: CustomImage(
                        filename: 'assets/pmg1212.png',
                        widthPercent: 0.4,
                        heightPercent: 0.2,
                      ),
                    ),
                    TableCell(
                      child: CustomImage(
                        filename: 'assets/pmg1212.png',
                        widthPercent: 0.4,
                        heightPercent: 0.2,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: GestureDetector(
                        onTap: () {
                          // 링크를 클릭했을 때 실행할 동작을 정의합니다.
                          // 예를 들어, 웹 페이지로 이동하거나 특정 기능을 수행할 수 있습니다.
                        },
                        child: Text(
                          'github.com/parkmingyun99',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: GestureDetector(
                        onTap: () {
                          // 링크를 클릭했을 때 실행할 동작을 정의합니다.
                          // 예를 들어, 웹 페이지로 이동하거나 특정 기능을 수행할 수 있습니다.
                        },
                        child: Text(
                          'github.com/parkmingyun99',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),TableCell(
                      child: GestureDetector(
                        onTap: () {
                          // 링크를 클릭했을 때 실행할 동작을 정의합니다.
                          // 예를 들어, 웹 페이지로 이동하거나 특정 기능을 수행할 수 있습니다.
                        },
                        child: Text(
                          'github.com/parkmingyun99',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text(''),
                    ),
                    TableCell(
                      child: Text(''),
                    ),
                    TableCell(
                      child: Text(''),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text(''),
                    ),
                    TableCell(
                      child: Text(''),
                    ),
                    TableCell(
                      child: Text(''),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text(''),
                    ),
                    TableCell(
                      child: Text('<AI master>'),
                    ),
                    TableCell(
                      child: Text(''),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: CustomImage(
                        filename: 'assets/pmg1212.png',
                        widthPercent: 0.4,
                        heightPercent: 0.2,
                      ),
                    ),
                    TableCell(
                      child: CustomImage(
                        filename: 'assets/pmg1212.png',
                        widthPercent: 0.4,
                        heightPercent: 0.2,
                      ),
                    ),
                    TableCell(
                      child: CustomImage(
                        filename: 'assets/pmg1212.png',
                        widthPercent: 0.4,
                        heightPercent: 0.2,
                      ),
                    ),
                  ],
                ),

                TableRow(
                  children: [
                    TableCell(
                      child: GestureDetector(
                        onTap: () {
                          // 링크를 클릭했을 때 실행할 동작을 정의합니다.
                          // 예를 들어, 웹 페이지로 이동하거나 특정 기능을 수행할 수 있습니다.
                        },
                        child: Text(
                          'github.com/parkmingyun99',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: GestureDetector(
                        onTap: () {
                          // 링크를 클릭했을 때 실행할 동작을 정의합니다.
                          // 예를 들어, 웹 페이지로 이동하거나 특정 기능을 수행할 수 있습니다.
                        },
                        child: Text(
                          'github.com/parkmingyun99',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),TableCell(
                      child: GestureDetector(
                        onTap: () {
                          // 링크를 클릭했을 때 실행할 동작을 정의합니다.
                          // 예를 들어, 웹 페이지로 이동하거나 특정 기능을 수행할 수 있습니다.
                        },
                        child: Text(
                          'github.com/parkmingyun99',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),





          // Text('<app develop>'),






          Container(child:Align(
            alignment: Alignment.bottomCenter,
            child:
            CustomButton(
              onTap: () {
                context.read<FirebaseAuthMethods>().signOut(context);
              },
              text: '로그아웃하기',bg_color: Color.fromRGBO(0, 0, 0, 1),tx_color: Color.fromRGBO(255, 255, 255, 1),
            ),
          ),),


        ],
    ),

    );
  }

}

class Category {
  final String imagUrl;
  final String name;

  Category({required this.imagUrl, required this.name});
}
