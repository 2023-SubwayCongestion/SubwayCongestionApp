import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class BottomBar extends StatefulWidget {
  final _selectedIndex;
  final _onItemTapped;
  const BottomBar(this._selectedIndex, this._onItemTapped, {Key? key})
      : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '홈화면',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.cookie_sharp),
          label: '현우',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.handshake_sharp),
          label: '민균',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_rounded),
          label: '신고하기',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_sharp),
          label: '마이페이지',
        ),
      ],
      currentIndex: widget._selectedIndex,
      selectedItemColor: Colors.amber[800],
      unselectedItemColor: Colors.grey,
      onTap: widget._onItemTapped,
    );
  }
}
