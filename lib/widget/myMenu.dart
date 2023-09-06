import 'package:flutter/material.dart';
import 'package:flutter_donation_buttons/flutter_donation_buttons.dart';
import 'package:provider/provider.dart';
import '../services/firebase_auth_methods.dart';
import '../widget/custom_button.dart';
import '../widget/custom_image.dart';

class myMenu extends StatelessWidget {

  const myMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/logo.png'),
              backgroundColor: Colors.white,
            ),
            accountName: Text('멋진쟃빛박쥐#0011'),
            accountEmail: Text(user?.email ?? ''),
            onDetailsPressed: () {
              print('arrow is clicked');
            },
            decoration: BoxDecoration(
              color: Color.fromRGBO(84, 162, 154, 1),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
              ),
            ),
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
            leading: Icon(Icons.door_front_door_outlined, color: Colors.grey[850]),
            title: Text('로그아웃'),
            onTap: () {
              context.read<FirebaseAuthMethods>().signOut(context);
            },
            trailing: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

