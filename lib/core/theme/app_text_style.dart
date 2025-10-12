import 'package:flutter/material.dart';

class AppTextStyles extends ThemeExtension<AppTextStyles> {
  final TextStyle font12RegularLabelColor;
  final TextStyle font12RegularSecondaryColor;
  final TextStyle font12RegularPrimaryColor;

  final TextStyle font14RegularSecondaryColor;
  final TextStyle font14RegularLabelColor;
  final TextStyle font14RegularPrimaryColor;
  final TextStyle font14BoldPrimaryColor;
  final TextStyle font14BoldSecondaryColor;
  final TextStyle font14SemiBoldSecondaryColor;

  final TextStyle font16RegularPrimaryColor;
  final TextStyle font16BoldPrimaryColor;
  final TextStyle font16BoldWhiteColor;
  final TextStyle font16RegularLabelColor;
  final TextStyle font16RegularSecondaryColor;
  final TextStyle font16BoldSecondaryColor;

  final TextStyle font18RegularLabelColor;
  final TextStyle font20RegularLabelColor;

  final TextStyle font18BoldPrimaryColor;
  final TextStyle font18BoldSecondaryColor;

  final TextStyle font20BoldSecondaryColor;
  final TextStyle font14RegularGrayColor;
  final TextStyle font10SemiBoldGreenColor;

  AppTextStyles({
    required this.font20RegularLabelColor,
    required this.font12RegularLabelColor,
    required this.font16RegularLabelColor,
    required this.font16RegularPrimaryColor,
    required this.font14RegularSecondaryColor,
    required this.font16BoldPrimaryColor,
    required this.font20BoldSecondaryColor,
    required this.font16BoldWhiteColor,
    required this.font16RegularSecondaryColor,
    required this.font18RegularLabelColor,
    required this.font18BoldPrimaryColor,
    required this.font18BoldSecondaryColor,
    required this.font14BoldPrimaryColor,
    required this.font16BoldSecondaryColor,
    required this.font14BoldSecondaryColor,
    required this.font14RegularPrimaryColor,
    required this.font12RegularSecondaryColor,
    required this.font14SemiBoldSecondaryColor,
    required this.font14RegularLabelColor,
    required this.font12RegularPrimaryColor,
    required this.font14RegularGrayColor,
    required this.font10SemiBoldGreenColor,
  });

  @override
  ThemeExtension<AppTextStyles> copyWith() {
    // don t need to implement this
    throw UnimplementedError();
  }

  @override
  ThemeExtension<AppTextStyles> lerp(
      covariant ThemeExtension<AppTextStyles>? other, double t) {
    if (other is! AppTextStyles) {
      return this;
    } else {
      return AppTextStyles(
        font20BoldSecondaryColor: TextStyle.lerp(
            font20BoldSecondaryColor, other.font20BoldSecondaryColor, t)!,
        font20RegularLabelColor: TextStyle.lerp(
            font20RegularLabelColor, other.font20RegularLabelColor, t)!,
        font16BoldWhiteColor: TextStyle.lerp(
            font16BoldWhiteColor, other.font16BoldWhiteColor, t)!,
        font16BoldPrimaryColor: TextStyle.lerp(
            font16BoldPrimaryColor, other.font16BoldPrimaryColor, t)!,
        font16RegularLabelColor: TextStyle.lerp(
            font16RegularLabelColor, other.font16RegularLabelColor, t)!,
        font16RegularPrimaryColor: TextStyle.lerp(
            font16RegularPrimaryColor, other.font16RegularPrimaryColor, t)!,
        font14RegularSecondaryColor: TextStyle.lerp(
            font14RegularSecondaryColor, other.font14RegularSecondaryColor, t)!,
        font12RegularLabelColor: TextStyle.lerp(
            font12RegularLabelColor, other.font12RegularLabelColor, t)!,
        font16RegularSecondaryColor: TextStyle.lerp(
            font16RegularSecondaryColor, other.font16RegularSecondaryColor, t)!,
        font18RegularLabelColor: TextStyle.lerp(
            font18RegularLabelColor, other.font18RegularLabelColor, t)!,
        font18BoldPrimaryColor: TextStyle.lerp(
            font18BoldPrimaryColor, other.font18BoldPrimaryColor, t)!,
        font18BoldSecondaryColor: TextStyle.lerp(
            font18BoldSecondaryColor, other.font18BoldSecondaryColor, t)!,
        font14BoldPrimaryColor: TextStyle.lerp(
            font14BoldPrimaryColor, other.font14BoldPrimaryColor, t)!,
        font16BoldSecondaryColor: TextStyle.lerp(
            font16BoldSecondaryColor, other.font16BoldSecondaryColor, t)!,
        font14BoldSecondaryColor: TextStyle.lerp(
            font14BoldSecondaryColor, other.font14BoldSecondaryColor, t)!,
        font14RegularPrimaryColor: TextStyle.lerp(
            font14RegularPrimaryColor, other.font14RegularPrimaryColor, t)!,
        font12RegularSecondaryColor: TextStyle.lerp(
            font12RegularSecondaryColor, other.font12RegularSecondaryColor, t)!,
        font14SemiBoldSecondaryColor: TextStyle.lerp(
            font14SemiBoldSecondaryColor,
            other.font14SemiBoldSecondaryColor,
            t)!,
        font14RegularLabelColor: TextStyle.lerp(
            font14RegularLabelColor, other.font14RegularLabelColor, t)!,
        font12RegularPrimaryColor: TextStyle.lerp(
            font12RegularPrimaryColor, other.font12RegularPrimaryColor, t)!,
        font14RegularGrayColor: TextStyle.lerp(
            font14RegularGrayColor, other.font14RegularGrayColor, t)!,
        font10SemiBoldGreenColor: TextStyle.lerp(
            font10SemiBoldGreenColor, other.font10SemiBoldGreenColor, t)!,
      );
    }
  }
}
