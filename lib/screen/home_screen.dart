import 'package:subway_congestion/screen/subwayLine_screen.dart';
import 'package:subway_congestion/services/firebase_auth_methods.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/bottom_bar.dart';
import '../widget/custom_button.dart';
import 'mypage_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  static const List<Widget> _widgetOptions = <Widget>[
    // ocr(),
    // RecipeScreen(),
    // showGroupBuying(),
    // showMyChat(),
    SubwayLine(),
    UserPage(),
    UserPage(),
    UserPage(),

    // TownScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;

    return Scaffold(
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     // 이하 코드 생략...
      //
      //     CustomButton(
      //       onTap: () {
      //         context.read<FirebaseAuthMethods>().signOut(context);
      //       },
      //       text: 'Sign out',
      //     ),
      //     CustomButton(
      //       onTap: () {
      //         context.read<FirebaseAuthMethods>().deleteAccount(context);
      //       },
      //       text: 'Delete Account',
      //     ),
      //   ],
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomBar(_selectedIndex, _onItemTapped),
    );
  }
}
