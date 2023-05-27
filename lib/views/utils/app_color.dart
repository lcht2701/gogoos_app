import 'package:flutter/material.dart';

class AppColor {
  static Color primaryColor = const Color(0xFFF8F8F8);
  static Color orangeColor = const Color(0xFFFF6B00);
  static Color orangeSoftColor = const Color(0xFFff9933);
  static Color lightColor = Colors.white;
  static Color darkColor = Colors.black;
  static LinearGradient bottomShadow = LinearGradient(colors: [
    const Color(0xFF7c7b80).withOpacity(0.2),
    const Color(0xFF7c7b80).withOpacity(0)
  ], begin: Alignment.bottomCenter, end: Alignment.topCenter);
  static LinearGradient linearBlackBottom = LinearGradient(
      colors: [Colors.black.withOpacity(0.45), Colors.black.withOpacity(0)],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter);
  static LinearGradient linearBlackTop = LinearGradient(
      colors: [Colors.black.withOpacity(0.5), Colors.transparent],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
}
