import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardWithGrayBorder extends StatelessWidget {
  const CardWithGrayBorder({super.key, required this.child, this.color});
  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 15.allPadding,
      decoration: BoxDecoration(
        color: color ?? context.colors.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: context.colors.strokeColor, width: 1),
      ),
      child: child,
    );
  }
}