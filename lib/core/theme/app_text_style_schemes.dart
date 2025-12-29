import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_colors_schemes.dart';
import 'app_text_style.dart';

abstract class AppTextStylesSchemes {
  static final AppColors _appLightColors = AppColorsSchemes.light;
  static AppTextStyles light = AppTextStyles(
    font16SemiBoldWhiteColor: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: _appLightColors.whiteColor,
    ),
    font17MediumWhiteColor: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w500,
      color: _appLightColors.whiteColor,
    ),
    font18SemiBoldWhiteColor: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: _appLightColors.whiteColor,
    ),
    font14RegularSecondaryColor: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: _appLightColors.secondaryColor,
    ),
    font14MediumSecondaryColor: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: _appLightColors.secondaryColor,
    ),
    font14SemiBoldSecondaryColor: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: _appLightColors.secondaryColor,
    ),
    font14BoldSecondaryColor: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: _appLightColors.secondaryColor,
    ),
    font15MediumSecondaryColor: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: _appLightColors.secondaryColor,
    ),
    font15SemiBoldSecondaryColor: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: _appLightColors.secondaryColor,
    ),
    font16RegularSecondaryColor: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: _appLightColors.secondaryColor,
    ),
    font16MediumSecondaryColor: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: _appLightColors.secondaryColor,
    ),
    font16SemiBoldSecondaryColor: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: _appLightColors.secondaryColor,
    ),
    font16BoldSecondaryColor: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: _appLightColors.secondaryColor,
    ),

    font18SemiBoldSecondaryColor: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: _appLightColors.secondaryColor,
    ),
    font18BoldSecondaryColor: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: _appLightColors.secondaryColor,
    ),
    font17SemiBoldSecondaryColor: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w600,
      color: _appLightColors.secondaryColor,
    ),
    font20SemiBoldSecondaryColor: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: _appLightColors.secondaryColor,
    ),
    font20BoldSecondaryColor: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: _appLightColors.secondaryColor,
    ),
    font24BoldSecondaryColor: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: _appLightColors.secondaryColor,
    ),
    font14MediumGrayColor: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: _appLightColors.grayColor,
    ),
    font14RegularGrayColor: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: _appLightColors.grayColor,
    ),
    font15MediumGrayColor: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: _appLightColors.grayColor,
    ),
    font15RegularGrayColor: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: _appLightColors.grayColor,
    ),
    font14BoldPrimaryColor: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: _appLightColors.primaryColor,
    ),
    font22BoldPrimaryColor: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: _appLightColors.primaryColor,
    ),
    font14MediumPrimaryColor: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: _appLightColors.primaryColor,
    ),
    font15MediumPrimaryColor: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: _appLightColors.primaryColor,
    ),
    font16MediumPrimaryColor: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: _appLightColors.primaryColor,
    ),
    font17MediumPrimaryColor: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w500,
      color: _appLightColors.primaryColor,
    ),
    font13RegularPrimaryColor: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: _appLightColors.primaryColor,
    ),
    font13SemiBoldPrimaryColor: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: _appLightColors.primaryColor,
    ),
    font14RegularPrimaryColor: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: _appLightColors.primaryColor,
    ),
    font15RegularPrimaryColor: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: _appLightColors.primaryColor,
    ),
    font16RegularPrimaryColor: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: _appLightColors.primaryColor,
    ),
    font20SemiBoldPrimaryColor: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: _appLightColors.primaryColor,
    ),
    font14SemiBoldPrimaryColor: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: _appLightColors.primaryColor,
    ),
    font20MediumSecondaryColor: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: _appLightColors.secondaryColor,
    ),
  );

  static AppTextStyles dark = light;
}
