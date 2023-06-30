import 'package:subway_congestion/services/firebase_auth_methods.dart';
import 'package:subway_congestion/widget/custom_image.dart';
import 'package:subway_congestion/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../header.dart';

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
      appBar: AppBar(
        backgroundColor: getColor('main2'),
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
          color: getColor('main1'),
          // X 버튼의 색상을 변경합니다. 원하는 색상으로 변경하세요.
          onPressed: () {
            Navigator.of(context).pop(); // 뒤로 가기 버튼과 동일한 동작을 수행합니다.
          },
        ),

      ),
      resizeToAvoidBottomInset: false,
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
                  widthPercent: 0.7,
                  heightPercent: 0.4,
                ),
                // SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  // margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                    controller: emailController,
                    hintText: '이메일을 입력해주세요.',
                    isObscure: false,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  // margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                    controller: passwordController,
                    hintText: '비밀번호를 입력해주세요.',
                    isObscure: true,
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: ElevatedButton(
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
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
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
