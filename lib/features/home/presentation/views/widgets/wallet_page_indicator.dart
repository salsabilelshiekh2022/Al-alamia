import 'package:alalamia/core/helper/app_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WalletPageIndicator extends StatelessWidget {
  const WalletPageIndicator({
    super.key,
    required this.controller,
    required this.count,
  });

  final PageController controller;
  final int count;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: count,
      effect: ExpandingDotsEffect(
        dotHeight: 6.h,
        dotWidth: 8.w,
        activeDotColor: context.colors.primaryColor,
        dotColor: context.colors.grayColor,
        spacing: 4.w,
      ),
    );
  }
}
