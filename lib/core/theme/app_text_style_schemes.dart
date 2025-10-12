import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_colors_schemes.dart';
import 'app_text_style.dart';

abstract class AppTextStylesSchemes {
  static  AppColors _appLightColors = AppColorsSchemes.light;
  static AppTextStyles light = AppTextStyles(
      font12RegularLabelColor: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: _appLightColors.greenColor,
      ),
      );
  static AppTextStyles dark = light;
}
