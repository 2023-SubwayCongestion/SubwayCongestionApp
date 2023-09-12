import 'package:subway_congestion/screen/login_email_password_screen.dart';
import 'package:subway_congestion/screen/signup_email_password_screen.dart';
import 'package:subway_congestion/widget/custom_button.dart';
import 'package:flutter/material.dart';
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
                SizedBox(
                  height: 100,
                ),
                CustomImage(
                  filename: 'assets/logo.png',
                  widthPercent: 0.7,
                  heightPercent: 0.4,
                ),
                SizedBox(
                  height: 50,
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
                  padding: EdgeInsets.only(bottom: 15),
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
