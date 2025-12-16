import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_text_style.dart';
import 'custom_svg_builder.dart';

class MainButton extends StatelessWidget {
  const MainButton({super.key, required this.title, required this.onTap, this.color, this.borderColor, this.icon});
  final String title;
  final void Function() onTap;
  final Color? color ;
  final Color? borderColor;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    final AppTextStyles appTextStyles = Theme.of(
      context,
    ).extension<AppTextStyles>()!;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50.h,
        decoration: BoxDecoration(  
          color: color,     
          gradient:color != null ? null : context.colors.buttonGradientColor,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: borderColor ?? Colors.transparent, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) CustomSvgBuilder(path: icon!, width: 24, height: 24, color: Colors.white).onlyPadding(leftPadding: 6),
            Text(title, style: appTextStyles.font17MediumWhiteColor),
          ],
        ),  
      ),
    );
  }
}
