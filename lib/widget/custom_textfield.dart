import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 화면 크기 구하기
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // 버튼 크기를 화면 크기의 일정 비율로 설정하기
    final textFieldWidth = screenWidth * 0.5; // 화면 폭의 90%로 버튼 폭 설정
    final textFieldHeight = screenHeight * 0.05; // 화면 높이의 10%로 버튼 높이 설정
    return Container(
      width: textFieldWidth,
      height: textFieldHeight,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // 그림자 색상
            spreadRadius: 1, // 그림자 확산 정도
            blurRadius: 6, // 그림자 흐림 정도
            offset: Offset(0, 3), // 그림자 위치
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.transparent, width: 0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.transparent, width: 0),
          ),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          filled: true,
          fillColor: const Color(0xffF5F6FA),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
