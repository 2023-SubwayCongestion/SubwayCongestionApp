import 'package:subway_congestion/screen/login_email_password_screen.dart';
// import 'package:subway_congestion/screen/phone_screen.dart';
import 'package:subway_congestion/screen/signup_email_password_screen.dart';
import 'package:subway_congestion/services/firebase_auth_methods.dart';
import 'package:subway_congestion/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subway_congestion/widget/custom_image.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.maxFinite,
              height: double.maxFinite,
              color: Color.fromRGBO(84, 162, 154, 1),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImage(
                  filename: 'assets/logo.png',
                  widthPercent: 0.5,
                  heightPercent: 0.5,
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 50),
                ),
                CustomButton(
                  onTap: () {
                    Navigator.pushNamed(context, EmailPasswordLogin.routeName);
                  },
                  text: 'Login',
                  bg_color: Colors.white,
                  tx_color: Colors.black,
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                ),
                CustomOutlinedButton(
                  onTap: () {
                    Navigator.pushNamed(context, EmailPasswordSignup.routeName);
                  },

                  text: 'Sign in',
                  borderColor: Colors.white,
                  textColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
