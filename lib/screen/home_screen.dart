import 'package:subway_congestion/screen/notification_screen.dart';
import 'package:subway_congestion/screen/report_screen.dart';
import 'package:subway_congestion/screen/subwayCongestion_screen.dart';
import 'package:subway_congestion/screen/subwayLine_screen.dart';
import 'package:subway_congestion/services/firebase_auth_methods.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/bottom_bar.dart';

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
    SubwayLine(),
    // ScatterChartSample2(),
    ReportPage(),
    NotificationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;

    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomBar(_selectedIndex, _onItemTapped),
    );
  }
}
