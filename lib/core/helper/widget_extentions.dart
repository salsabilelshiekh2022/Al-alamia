import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension WidgetExtension on Widget {
  Widget horizontalPadding(double padding) => Padding(
    padding: EdgeInsets.symmetric(horizontal: padding.w),
    child: this,
  );
  Widget verticalPadding(double padding) => Padding(
    padding: EdgeInsets.symmetric(vertical: padding.h),
    child: this,
  );
  Widget allPadding(double padding) =>
      Padding(padding: EdgeInsets.all(padding.r), child: this);
  Widget onlyPadding({
    double topPadding = 0,
    double bottomPadding = 0,
    double rightPadding = 0,
    double leftPadding = 0,
  }) => Padding(
    padding: EdgeInsets.only(
      bottom: bottomPadding.h,
      left: leftPadding.w,
      right: rightPadding.w,
      top: topPadding.h,
    ),
    child: this,
  );
  Widget center() => Center(child: this);

  Widget clipRRect({BorderRadius borderRadius = BorderRadius.zero}) =>
      ClipRRect(borderRadius: borderRadius, child: this);
}
