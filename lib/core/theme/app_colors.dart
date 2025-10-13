import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color whiteColor;
  final Color primaryColor;
  final Color secondaryColor;
  final Color grayColor;
  final Color strokeColor;
  final Color backgroundFieldColor;
  final Color redColor;
  final Color greenColor;
  final Color yellowColor;
  final Gradient buttonGradientColor;
  final Gradient backGroundGradientColor;

  const AppColors({
    required this.whiteColor,
    required this.primaryColor,
    required this.secondaryColor,
    required this.grayColor,
    required this.strokeColor,
    required this.backgroundFieldColor,
    required this.redColor,
    required this.greenColor,
    required this.yellowColor,
    required this.buttonGradientColor,
    required this.backGroundGradientColor,
  });

  @override
  ThemeExtension<AppColors> copyWith() {
    // TODO: implement copyWith
    throw UnimplementedError();
  }

  @override
  ThemeExtension<AppColors> lerp(
    covariant ThemeExtension<AppColors>? other,
    double t,
  ) {
    if (other is! AppColors) {
      return this;
    } else {
      return AppColors(
        whiteColor: Color.lerp(whiteColor, other.whiteColor, t)!,
        primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,

        secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t)!,

        grayColor: Color.lerp(grayColor, other.grayColor, t)!,

        strokeColor: Color.lerp(strokeColor, other.strokeColor, t)!,

        backgroundFieldColor: Color.lerp(
          backgroundFieldColor,
          other.backgroundFieldColor,
          t,
        )!,

        redColor: Color.lerp(redColor, other.redColor, t)!,

        greenColor: Color.lerp(greenColor, other.greenColor, t)!,

        yellowColor: Color.lerp(yellowColor, other.yellowColor, t)!,
        buttonGradientColor: Gradient.lerp(
          buttonGradientColor,
          other.buttonGradientColor,
          t,
        )!,
        backGroundGradientColor: Gradient.lerp(
          backGroundGradientColor,
          other.backGroundGradientColor,
          t,
        )!,
      );
    }
  }
}
