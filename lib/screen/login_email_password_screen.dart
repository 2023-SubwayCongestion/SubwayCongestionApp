import 'package:subway_congestion/services/firebase_auth_methods.dart';
import 'package:subway_congestion/widget/custom_image.dart';
import 'package:subway_congestion/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailPasswordLogin extends StatefulWidget {
  static String routeName = '/login-email-password';
  const EmailPasswordLogin({Key? key}) : super(key: key);

  @override
  _EmailPasswordLoginState createState() => _EmailPasswordLoginState();
}

class _EmailPasswordLoginState extends State<EmailPasswordLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void loginUser() {
    context.read<FirebaseAuthMethods>().loginWithEmail(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            color: Color.fromRGBO(245, 243, 228, 1),
          ),
          Center(
            child: Column(
              children: [
                CustomImage(
                  filename: 'assets/login.png',
                  widthPercent: 0.5,
                  heightPercent: 0.5,
                ),
                // SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Container(
                  // margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                    controller: emailController,
                    hintText: '이메일을 입력해주세요.',
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  // margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                    controller: passwordController,
                    hintText: '비밀번호를 입력해주세요.',
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: loginUser,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color.fromRGBO(84, 162, 154, 1)),
                    textStyle: MaterialStateProperty.all(
                      const TextStyle(color: Colors.white),
                    ),
                    minimumSize: MaterialStateProperty.all(
                      Size(MediaQuery.of(context).size.width / 2.5, 50),
                    ),
                  ),
                  child: const Text(
                    "확인",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
