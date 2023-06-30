import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../services/firebase_auth_methods.dart';
import '../widget/custom_button.dart';
import 'home_screen.dart';


class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPage createState() => _UserPage();
}

class _UserPage extends State<UserPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('집인데 집가고싶다..',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
        elevation: 3.0,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 이하 코드 생략...

        CustomButton(
          onTap: () {
            context.read<FirebaseAuthMethods>().signOut(context);
          },
          text: 'Sign out',bg_color: Color.fromRGBO(0, 0, 0, 1),tx_color: Color.fromRGBO(255, 255, 255, 1),
        ),
        CustomButton(
          onTap: () {
            context.read<FirebaseAuthMethods>().deleteAccount(context);
          },
          text: 'Delete Account', bg_color: Color.fromRGBO(0, 0, 0, 1),tx_color: Color.fromRGBO(255, 255, 255, 1),
        ),
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
