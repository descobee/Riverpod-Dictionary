import 'package:flutter/material.dart';

class AppColors {
  static Color? backgroundColor = Colors.blueGrey[900];
  static Color? whiteColor = Colors.white;
  static Color? orangeColor = Colors.orangeAccent;
}

Widget ymargin(double height) {
  return SizedBox(
    height: height,
  );
}

Widget xmargin(double width) {
  return SizedBox(
    width: width,
  );
}
