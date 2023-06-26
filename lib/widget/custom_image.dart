import 'package:flutter/material.dart';


class CustomImage extends StatelessWidget {
  const CustomImage({
    super.key,
    required this.filename,
    required this.widthPercent,
    required this.heightPercent,
  });
  final String filename;
  final double widthPercent;
  final double heightPercent;

  @override
  Widget build(BuildContext context) {
    // 현재 화면의 크기를 구합니다.
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // 이미지 크기를 화면의 비율에 맞추려면 이 값을 수정하십시오.
    final imageWidth = screenWidth * widthPercent; // 화면 폭의 50%로 이미지 폭 설정
    final imageHeight = screenHeight * heightPercent; // 화면 높이의 50%로 이미지 높이 설정

    return Container(
      child: Image.asset(
        filename,
        width: imageWidth,
        height: imageHeight,
      ),
    );
  }
}
