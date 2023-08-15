import 'package:flutter/material.dart';

Color getColor(String colorName){
  Color chooseColor;

  switch(colorName){
    case 'main1':
      chooseColor = Color.fromRGBO(84, 162, 154, 1);
      break;
    case 'main2':
      chooseColor = Color.fromRGBO(245, 243, 228, 1);
      break;
    case 'grey':
      chooseColor = Colors.grey;
      break;
    case 'white':
      chooseColor = Colors.white;
      break;
    default:
      chooseColor = Color.fromRGBO(84, 162, 154, 1);
      break;
  }

  return chooseColor;
}