import 'package:alalamia/core/helper/app_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_text_style.dart';

class MainButton extends StatelessWidget {
  const MainButton({super.key, required this.title, required this.onTap});
  final String title;
  final void Function() onTap;

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
          gradient: context.colors.buttonGradientColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: Text(title, style: appTextStyles.font17MediumWhiteColor),
        ),
      ),
    );
  }
}
