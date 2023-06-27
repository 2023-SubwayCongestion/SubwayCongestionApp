// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// import 'package:provider/provider.dart';
//
// import '../widget/bottom_bar.dart';
//
// class MainScreen extends StatefulWidget {
//   const MainScreen({Key? key}) : super(key: key);
//
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   final _authentication = FirebaseAuth.instance;
//   User? loggedUser;
//
//   // bottom bar info
//   int _selectedIndex = 0;
//   static const TextStyle optionStyle =
//   TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
//   static const List<Widget> _widgetOptions = <Widget>[
//     // ocr(),
//     // RecipeScreen(),
//     // showGroupBuying(),
//     // showMyChat(),
//     // UserPage(),
//     // TownScreen(),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getCurrentUser();
//   }
//
//   void getCurrentUser() {
//     try {
//       final user = _authentication.currentUser;
//       if (user != null) {
//         loggedUser = user;
//         print(loggedUser!.email);
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     //UserProvider _userProvider = Provider.of<UserProvider>(context);
//     return Scaffold(
//       // body: Center(
//       //   child: _widgetOptions.elementAt(_selectedIndex),
//       // ),
//       bottomNavigationBar: BottomBar(_selectedIndex, _onItemTapped),
//     );
//   }
// }
