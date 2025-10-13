import 'package:alalamia/core/helper/app_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthFooterWidget extends StatelessWidget {
  const AuthFooterWidget({
    super.key,
    required this.clickable,
    required this.notClickable,
    required this.onTap,
    this.notClickableColor,
    this.fontSize,
    this.hasUnderLine = true,
    this.clickableColor,
  });

  final String clickable;
  final String notClickable;
  final Color? notClickableColor;
  final double? fontSize;
  final Color? clickableColor;
  final bool hasUnderLine;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          notClickable,
          style: context.textStyles.font16RegularSecondaryColor,
        ),
        2.horizontalSpace,
        InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 36.h,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                clickable,
                style: context.textStyles.font16RegularPrimaryColor.copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: context.colors.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
