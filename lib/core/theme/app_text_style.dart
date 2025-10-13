import 'package:flutter/material.dart';

class AppTextStyles extends ThemeExtension<AppTextStyles> {
  final TextStyle font16SemiBoldWhiteColor;
  final TextStyle font17MediumWhiteColor;
  final TextStyle font18SemiBoldWhiteColor;
  final TextStyle font14RegularSecondaryColor;
  final TextStyle font14MediumSecondaryColor;
  final TextStyle font14SemiBoldSecondaryColor;
  final TextStyle font14BoldSecondaryColor;
  final TextStyle font15MediumSecondaryColor;
  final TextStyle font15SemiBoldSecondaryColor;
  final TextStyle font16RegularSecondaryColor;
  final TextStyle font16MediumSecondaryColor;
  final TextStyle font16SemiBoldSecondaryColor;
  final TextStyle font16BoldSecondaryColor;
  final TextStyle font17SemiBoldSecondaryColor;
  final TextStyle font18SemiBoldSecondaryColor;
  final TextStyle font18BoldSecondaryColor;
  final TextStyle font20SemiBoldSecondaryColor;
  final TextStyle font20BoldSecondaryColor;
  final TextStyle font24BoldSecondaryColor;
  final TextStyle font14RegularGrayColor;
  final TextStyle font14MediumGrayColor;
  final TextStyle font15RegularGrayColor;
  final TextStyle font15MediumGrayColor;
  final TextStyle font13RegularPrimaryColor;
  final TextStyle font13SemiBoldPrimaryColor;
  final TextStyle font14RegularPrimaryColor;
  final TextStyle font14MediumPrimaryColor;
  final TextStyle font14SemiBoldPrimaryColor;
  final TextStyle font14BoldPrimaryColor;
  final TextStyle font15RegularPrimaryColor;
  final TextStyle font15MediumPrimaryColor;
  final TextStyle font16RegularPrimaryColor;
  final TextStyle font16MediumPrimaryColor;
  final TextStyle font17MediumPrimaryColor;
  final TextStyle font20SemiBoldPrimaryColor;
  final TextStyle font22BoldPrimaryColor;
  final TextStyle font20MediumSecondaryColor;

  AppTextStyles({
    required this.font16SemiBoldWhiteColor,
    required this.font17MediumWhiteColor,
    required this.font18SemiBoldWhiteColor,
    required this.font14RegularSecondaryColor,
    required this.font14MediumSecondaryColor,
    required this.font14SemiBoldSecondaryColor,
    required this.font14BoldSecondaryColor,
    required this.font15MediumSecondaryColor,
    required this.font15SemiBoldSecondaryColor,
    required this.font16RegularSecondaryColor,
    required this.font16MediumSecondaryColor,
    required this.font16SemiBoldSecondaryColor,
    required this.font16BoldSecondaryColor,
    required this.font17SemiBoldSecondaryColor,
    required this.font18SemiBoldSecondaryColor,
    required this.font18BoldSecondaryColor,
    required this.font20SemiBoldSecondaryColor,
    required this.font20BoldSecondaryColor,
    required this.font24BoldSecondaryColor,
    required this.font14RegularGrayColor,
    required this.font14MediumGrayColor,
    required this.font15RegularGrayColor,
    required this.font15MediumGrayColor,
    required this.font13RegularPrimaryColor,
    required this.font13SemiBoldPrimaryColor,
    required this.font14RegularPrimaryColor,
    required this.font14MediumPrimaryColor,
    required this.font14SemiBoldPrimaryColor,
    required this.font14BoldPrimaryColor,
    required this.font15RegularPrimaryColor,
    required this.font15MediumPrimaryColor,
    required this.font16RegularPrimaryColor,
    required this.font16MediumPrimaryColor,
    required this.font17MediumPrimaryColor,
    required this.font20SemiBoldPrimaryColor,
    required this.font22BoldPrimaryColor,
    required this.font20MediumSecondaryColor,
  });

  @override
  ThemeExtension<AppTextStyles> copyWith() {
    // don t need to implement this
    throw UnimplementedError();
  }

  @override
  ThemeExtension<AppTextStyles> lerp(
    covariant ThemeExtension<AppTextStyles>? other,
    double t,
  ) {
    if (other is! AppTextStyles) {
      return this;
    } else {
      return AppTextStyles(
        font16SemiBoldWhiteColor: TextStyle.lerp(
          font16SemiBoldWhiteColor,
          other.font16SemiBoldWhiteColor,
          t,
        )!,
        font17MediumWhiteColor: TextStyle.lerp(
          font17MediumWhiteColor,
          other.font17MediumWhiteColor,
          t,
        )!,
        font18SemiBoldWhiteColor: TextStyle.lerp(
          font18SemiBoldWhiteColor,
          other.font18SemiBoldWhiteColor,
          t,
        )!,
        font14RegularSecondaryColor: TextStyle.lerp(
          font14RegularSecondaryColor,
          other.font14RegularSecondaryColor,
          t,
        )!,
        font14MediumSecondaryColor: TextStyle.lerp(
          font14MediumSecondaryColor,
          other.font14MediumSecondaryColor,
          t,
        )!,
        font14SemiBoldSecondaryColor: TextStyle.lerp(
          font14SemiBoldSecondaryColor,
          other.font14SemiBoldSecondaryColor,
          t,
        )!,
        font14BoldSecondaryColor: TextStyle.lerp(
          font14BoldSecondaryColor,
          other.font14BoldSecondaryColor,
          t,
        )!,
        font15MediumSecondaryColor: TextStyle.lerp(
          font15MediumSecondaryColor,
          other.font15MediumSecondaryColor,
          t,
        )!,
        font15SemiBoldSecondaryColor: TextStyle.lerp(
          font15SemiBoldSecondaryColor,
          other.font15SemiBoldSecondaryColor,
          t,
        )!,
        font16RegularSecondaryColor: TextStyle.lerp(
          font16RegularSecondaryColor,
          other.font16RegularSecondaryColor,
          t,
        )!,
        font16MediumSecondaryColor: TextStyle.lerp(
          font16MediumSecondaryColor,
          other.font16MediumSecondaryColor,
          t,
        )!,
        font16SemiBoldSecondaryColor: TextStyle.lerp(
          font16SemiBoldSecondaryColor,
          other.font16SemiBoldSecondaryColor,
          t,
        )!,
        font16BoldSecondaryColor: TextStyle.lerp(
          font16BoldSecondaryColor,
          other.font16BoldSecondaryColor,
          t,
        )!,
        font17SemiBoldSecondaryColor: TextStyle.lerp(
          font17SemiBoldSecondaryColor,
          other.font17SemiBoldSecondaryColor,
          t,
        )!,
        font18SemiBoldSecondaryColor: TextStyle.lerp(
          font18SemiBoldSecondaryColor,
          other.font18SemiBoldSecondaryColor,
          t,
        )!,
        font18BoldSecondaryColor: TextStyle.lerp(
          font18BoldSecondaryColor,
          other.font18BoldSecondaryColor,
          t,
        )!,
        font20SemiBoldSecondaryColor: TextStyle.lerp(
          font20SemiBoldSecondaryColor,
          other.font20SemiBoldSecondaryColor,
          t,
        )!,
        font20BoldSecondaryColor: TextStyle.lerp(
          font20BoldSecondaryColor,
          other.font20BoldSecondaryColor,
          t,
        )!,
        font24BoldSecondaryColor: TextStyle.lerp(
          font24BoldSecondaryColor,
          other.font24BoldSecondaryColor,
          t,
        )!,
        font14RegularGrayColor: TextStyle.lerp(
          font14RegularGrayColor,
          other.font14RegularGrayColor,
          t,
        )!,
        font14MediumGrayColor: TextStyle.lerp(
          font14MediumGrayColor,
          other.font14MediumGrayColor,
          t,
        )!,
        font15RegularGrayColor: TextStyle.lerp(
          font15RegularGrayColor,
          other.font15RegularGrayColor,
          t,
        )!,
        font15MediumGrayColor: TextStyle.lerp(
          font15MediumGrayColor,
          other.font15MediumGrayColor,
          t,
        )!,
        font13RegularPrimaryColor: TextStyle.lerp(
          font13RegularPrimaryColor,
          other.font13RegularPrimaryColor,
          t,
        )!,
        font13SemiBoldPrimaryColor: TextStyle.lerp(
          font13SemiBoldPrimaryColor,
          other.font13SemiBoldPrimaryColor,
          t,
        )!,
        font14RegularPrimaryColor: TextStyle.lerp(
          font14RegularPrimaryColor,
          other.font14RegularPrimaryColor,
          t,
        )!,
        font14MediumPrimaryColor: TextStyle.lerp(
          font14MediumPrimaryColor,
          other.font14MediumPrimaryColor,
          t,
        )!,
        font14SemiBoldPrimaryColor: TextStyle.lerp(
          font14SemiBoldPrimaryColor,
          other.font14SemiBoldPrimaryColor,
          t,
        )!,
        font14BoldPrimaryColor: TextStyle.lerp(
          font14BoldPrimaryColor,
          other.font14BoldPrimaryColor,
          t,
        )!,
        font15RegularPrimaryColor: TextStyle.lerp(
          font15RegularPrimaryColor,
          other.font15RegularPrimaryColor,
          t,
        )!,
        font15MediumPrimaryColor: TextStyle.lerp(
          font15MediumPrimaryColor,
          other.font15MediumPrimaryColor,
          t,
        )!,
        font16RegularPrimaryColor: TextStyle.lerp(
          font16RegularPrimaryColor,
          other.font16RegularPrimaryColor,
          t,
        )!,
        font16MediumPrimaryColor: TextStyle.lerp(
          font16MediumPrimaryColor,
          other.font16MediumPrimaryColor,
          t,
        )!,
        font17MediumPrimaryColor: TextStyle.lerp(
          font17MediumPrimaryColor,
          other.font17MediumPrimaryColor,
          t,
        )!,
        font20SemiBoldPrimaryColor: TextStyle.lerp(
          font20SemiBoldPrimaryColor,
          other.font20SemiBoldPrimaryColor,
          t,
        )!,
        font22BoldPrimaryColor: TextStyle.lerp(
          font22BoldPrimaryColor,
          other.font22BoldPrimaryColor,
          t,
        )!,
        font20MediumSecondaryColor: TextStyle.lerp(
          font20MediumSecondaryColor,
          other.font20MediumSecondaryColor,
          t,
        )!,
      );
    }
  }
}
