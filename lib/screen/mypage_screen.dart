import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
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



    );
  }

}

class Category {
  final String imagUrl;
  final String name;

  Category({required this.imagUrl, required this.name});
}
