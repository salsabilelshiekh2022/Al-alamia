import 'dart:ui';

import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppColorsSchemes {
  static AppColors light = AppColors(
    whiteColor: Colors.white,
    primaryColor: Color(0xff6E0084),
    secondaryColor: Color(0xff363A33),
    grayColor: Color(0xffB3B3B3),
    strokeColor: Color(0xff9B9B9B).withValues(alpha: 0.12),
    backgroundFieldColor: Color(0xff9b9b9b).withValues(alpha: 0.08),
    redColor: Color(0xffD76969),
    greenColor: Color(0xff00840F),
    yellowColor: Color(0xffDAB900),
    buttonGradientColor: const LinearGradient(
      begin: Alignment(0.05, 0.51),
      end: Alignment(1.00, 0.51),
      colors: [
        Color(0xFF800399),
        Color(0xFF7D02AB),
        Color(0xFF3F006A),
        Color(0xFF380043),
      ],
    ),
    backGroundGradientColor: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0x99130B83), // #130B83 with 60% opacity
        Color(0xFF6E0084), // #6E0084
      ],
    ),
    navigationGradientColor: LinearGradient(
      begin: Alignment(0.50, -0.00),
      end: Alignment(0.50, 1.00),
      colors: [const Color(0xFF6E0084), const Color(0xFF19001E)],
    ),
  );

  static AppColors dark = light;
}
