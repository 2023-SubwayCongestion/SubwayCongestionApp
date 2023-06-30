import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
    required this.bg_color,
    required this.tx_color,
  }) : super(key: key);
  final String text;
  final VoidCallback onTap;
  final Color bg_color;
  final Color tx_color;

  @override
  Widget build(BuildContext context) {
    // 화면 크기 구하기
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // 버튼 크기를 화면 크기의 일정 비율로 설정하기
    final buttonWidth = screenWidth * 0.6; // 화면 폭의 90%로 버튼 폭 설정
    final buttonHeight = screenHeight * 0.05; // 화면 높이의 10%로 버튼 높이 설정

    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            bg_color,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // 버튼의 모서리 둥글게 설정
            ),
          ),
        ),

        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(color: tx_color, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color borderColor;
  final Color textColor;

  CustomOutlinedButton({
    required this.text,
    required this.onTap,
    required this.borderColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    // 화면 크기 구하기
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // 버튼 크기를 화면 크기의 일정 비율로 설정하기
    final buttonWidth = screenWidth * 0.6; // 화면 폭의 90%로 버튼 폭 설정
    final buttonHeight = screenHeight * 0.05; // 화면 높이의 10%로 버튼 높이 설정

    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          side: BorderSide(color: borderColor, width: 2), // 테두리 설정
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
        ),
      ),
    );
  }
}
