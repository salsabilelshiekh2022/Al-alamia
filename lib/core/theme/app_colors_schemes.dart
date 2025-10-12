import 'dart:ui';

import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppColorsSchemes {
  static  AppColors light = AppColors(
    whiteColor: Colors.white,
    primaryColor: Color(0xff6E0084),
    secondaryColor: Color(0xff363A33),
    greyColor: Color(0xffB3B3B3),
    strokeColor: Color(0xff9B9B9B).withValues(alpha: 0.12),
    backgroundFieldColor: Color(0xff9b9b9b).withValues(alpha: 0.08),
    redColor: Color(0xffD76969),
    greenColor: Color(0xff00840F),
    yellowColor: Color(0xffDAB900),

  );

  static  AppColors dark = light;
}
